class_name WaveManager
extends Node2D
## O "diretor" das ondas (era o wave.py). Este nó DEVE ficar na posição (0, 0).
##
## Responsabilidades: quantas naves por onda (5, 6, 7...), onde posicioná-las,
## mover a formação (lado a lado, descendo na borda) e decidir quem atira.

signal wave_started(number: int, size: int)
signal wave_cleared(number: int, was_final: bool)

@export var plan: WavePlan

var wave_number: int = 0
var active: bool = false      # false = formação parada (entre ondas / fim de jogo)

var _enemies: Array[Enemy] = []
var _direction: float = 1.0
var _initial_count: int = 1
var _fire_timer: float = 1.0


# ------------------------------------------------------------ consultas
func size_of_wave(number: int) -> int:
	return mini(plan.first_size + (number - 1) * plan.size_step, plan.max_size)


func total_waves() -> int:
	return ceili(float(plan.max_size - plan.first_size) / float(plan.size_step)) + 1


func next_size() -> int:
	return size_of_wave(wave_number + 1)


func next_is_final() -> bool:
	return wave_number + 1 >= total_waves()


func is_final() -> bool:
	return wave_number >= total_waves()


## Alguma nave já passou da linha de defesa?
func reached(y_line: float) -> bool:
	for enemy in _enemies:
		if enemy.position.y + enemy.half_size().y >= y_line:
			return true
	return false


# ------------------------------------------------------------ ciclo de vida
func start_next_wave() -> void:
	wave_number += 1
	var size := size_of_wave(wave_number)
	_initial_count = size
	_direction = 1.0
	_spawn_formation(size)
	_reset_fire_timer()
	active = true
	wave_started.emit(wave_number, size)


func _spawn_formation(size: int) -> void:
	var screen_width := get_viewport_rect().size.x
	# Fileiras equilibradas: 6 -> [3, 3], 7 -> [4, 3], 10 -> [5, 5] ...
	var rows := ceili(float(size) / float(plan.enemies_per_row))
	var base_count := floori(size / float(rows))
	for row in rows:
		var count := base_count + (1 if row < size % rows else 0)
		var y := plan.formation_top + row * plan.spacing.y
		var start_x := screen_width / 2.0 - (count - 1) * plan.spacing.x / 2.0
		for col in count:
			var enemy := plan.enemy_scene.instantiate() as Enemy
			if plan.enemy_data != null:
				enemy.data = plan.enemy_data      # antes do add_child: o _ready já vê o dado
			add_child(enemy)
			enemy.position = Vector2(start_x + col * plan.spacing.x, y)
			enemy.died.connect(_on_enemy_died)
			_enemies.append(enemy)


func _on_enemy_died(enemy: Enemy) -> void:
	_enemies.erase(enemy)
	if _enemies.is_empty() and active:
		active = false
		wave_cleared.emit(wave_number, is_final())


# ------------------------------------------------------------ atualização
func _process(delta: float) -> void:
	if not active or _enemies.is_empty():
		return
	_move_formation(delta)
	_maybe_fire(delta)


## Curva de dificuldade: mais rápido a cada onda E conforme as naves morrem.
func current_speed() -> float:
	var killed_ratio := 1.0 - float(_enemies.size()) / float(_initial_count)
	return plan.base_speed + plan.speed_per_wave * (wave_number - 1) + plan.speedup_max * killed_ratio


func _move_formation(delta: float) -> void:
	var dx := _direction * current_speed() * delta
	var left := INF
	var right := -INF
	for enemy in _enemies:
		enemy.position.x += dx
		left = minf(left, enemy.position.x - enemy.half_size().x)
		right = maxf(right, enemy.position.x + enemy.half_size().x)

	var limit_left := plan.side_margin
	var limit_right := get_viewport_rect().size.x - plan.side_margin
	if _direction > 0.0 and right > limit_right:
		_bounce(limit_right - right)
	elif _direction < 0.0 and left < limit_left:
		_bounce(limit_left - left)


## Bateu na borda: desfaz o excesso, desce e inverte a direção.
func _bounce(correction: float) -> void:
	for enemy in _enemies:
		enemy.position.x += correction
		enemy.position.y += plan.drop
	_direction *= -1.0


func _reset_fire_timer() -> void:
	var interval := maxf(plan.fire_min_interval,
		plan.fire_base_interval - plan.fire_step_per_wave * (wave_number - 1))
	_fire_timer = interval * randf_range(0.6, 1.4)    # aleatório = menos previsível


func _maybe_fire(delta: float) -> void:
	_fire_timer -= delta
	if _fire_timer > 0.0:
		return
	_reset_fire_timer()
	var shooter := _enemies.pick_random() as Enemy
	var muzzle := shooter.global_position + Vector2(0.0, shooter.half_size().y)
	Projectile.spawn(plan.enemy_bullet_scene, get_tree(), muzzle, Vector2.DOWN)
