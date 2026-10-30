class_name ShooterLevel
extends LevelBase
## Fase de nave estilo Space Invaders. Liga WaveManager + nave + HUD e aplica as regras:
## ondas 5..10, +1 míssil a cada 3 abates, perde se as naves chegarem ou se as vidas acabarem.
##
## GANCHO PARA CHEFE: em _on_wave_cleared(), quando was_final for true, é aqui que
## você spawnaria o chefe e só chamaria _win() quando ele morrer.

enum State { INTERMISSION, PLAYING, ENDED }

@export var kills_per_missile: int = 3

@onready var _wave_manager: WaveManager = $WaveManager
@onready var _player: PlayerShip = $PlayerShip
@onready var _hud: Hud = $Hud

var _state: State = State.INTERMISSION
var _intermission_left: float = 0.0
var _kills: int = 0


func _ready() -> void:
	super()
	EventBus.enemy_killed.connect(_on_enemy_killed)
	_wave_manager.wave_started.connect(_on_wave_started)
	_wave_manager.wave_cleared.connect(_on_wave_cleared)
	_player.died.connect(_lose)
	score_changed.connect(_hud.set_score)

	_hud.bind_player(_player)
	_hud.set_score(0)
	_hud.set_wave(0, _wave_manager.total_waves())
	_hud.set_kill_progress(0, kills_per_missile)
	_begin_intermission()


func _process(delta: float) -> void:
	match _state:
		State.INTERMISSION:
			_intermission_left -= delta
			if _intermission_left <= 0.0:
				_start_wave()
		State.PLAYING:
			if _wave_manager.reached(_player.top_y()):
				_lose()                      # as naves invadiram!


# ------------------------------------------------------------ fluxo das ondas
func _begin_intermission() -> void:
	_state = State.INTERMISSION
	_intermission_left = _wave_manager.plan.intermission
	_player.can_shoot = false
	get_tree().call_group(&"enemy_projectiles", &"queue_free")   # limpa tiros inimigos

	var title := "ONDA FINAL"
	if not _wave_manager.next_is_final():
		title = "ONDA %d" % (_wave_manager.wave_number + 1)
	_hud.show_banner(title, "%d naves inimigas" % _wave_manager.next_size(), Color(0.98, 0.86, 0.5))


func _start_wave() -> void:
	_hud.hide_banner()
	_player.cannon.refill()                  # cada onda começa com o pente cheio
	_player.can_shoot = true
	_state = State.PLAYING
	_wave_manager.start_next_wave()


func _on_wave_started(number: int, _size: int) -> void:
	_hud.set_wave(number, _wave_manager.total_waves())


func _on_wave_cleared(_number: int, was_final: bool) -> void:
	if _state != State.PLAYING:
		return
	if was_final:
		_win()
	else:
		_begin_intermission()


# ------------------------------------------------------------ regras
func _on_enemy_killed(_world_position: Vector2, points: int) -> void:
	_kills += 1
	add_score(points * _wave_manager.wave_number)
	if _kills % kills_per_missile == 0:
		_player.missile_launcher.add_ammo(1)
		EventBus.missile_earned.emit()
	_hud.set_kill_progress(_kills % kills_per_missile, kills_per_missile)


func _win() -> void:
	_state = State.ENDED
	_player.can_shoot = false
	_hud.show_banner("FASE CONCLUÍDA", "", Color(0.55, 0.9, 0.65))
	await get_tree().create_timer(2.0).timeout
	complete_level()


func _lose() -> void:
	if _state == State.ENDED:
		return
	_state = State.ENDED
	_wave_manager.active = false
	_hud.show_banner("FIM DE JOGO", "", Color(0.92, 0.35, 0.35))
	await get_tree().create_timer(2.0).timeout
	fail_level()
