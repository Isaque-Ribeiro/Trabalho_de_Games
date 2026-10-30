class_name WeaponComponent
extends Node
## Munição + cooldown + recarga + disparo. Regras vêm de um WeaponData (.tres).
## Usado pelo canhão e pelo míssil da nave e pelo laser do astronauta.

signal ammo_changed(ammo: int, capacity: int)
signal reload_started
signal reload_finished

@export var data: WeaponData

var ammo: int = 0
var _cooldown_left: float = 0.0
var _reload_left: float = 0.0

var is_reloading: bool:
	get:
		return _reload_left > 0.0

## 0.0 a 1.0 (para barras/textos de recarga).
var reload_progress: float:
	get:
		if _reload_left <= 0.0 or data.reload_time <= 0.0:
			return 1.0
		return 1.0 - _reload_left / data.reload_time


func _ready() -> void:
	assert(data != null, "WeaponComponent precisa de um WeaponData")
	ammo = data.capacity if data.starting_ammo < 0 else data.starting_ammo
	ammo_changed.emit(ammo, data.capacity)


func _process(delta: float) -> void:
	_cooldown_left = maxf(0.0, _cooldown_left - delta)
	if _reload_left > 0.0:
		_reload_left -= delta
		if _reload_left <= 0.0:
			_reload_left = 0.0
			ammo = data.capacity
			ammo_changed.emit(ammo, data.capacity)
			reload_finished.emit()


func can_fire() -> bool:
	return ammo > 0 and _cooldown_left <= 0.0 and not is_reloading


## Tenta atirar. Devolve true se um projétil foi criado.
func try_fire(origin: Vector2, direction: Vector2) -> bool:
	if not can_fire():
		return false
	ammo -= 1
	_cooldown_left = data.cooldown
	Projectile.spawn(data.projectile_scene, get_tree(), origin, direction)
	ammo_changed.emit(ammo, data.capacity)
	if ammo == 0 and data.reloadable:
		start_reload()          # pente vazio: recarrega sozinho
	return true


func start_reload() -> void:
	if data.reloadable and not is_reloading and ammo < data.capacity:
		_reload_left = data.reload_time
		reload_started.emit()


## Enche o pente na hora (usado no começo de cada onda).
func refill() -> void:
	_reload_left = 0.0
	ammo = data.capacity
	ammo_changed.emit(ammo, data.capacity)


## Recompensa de munição (ex.: +1 míssil a cada 3 abates).
func add_ammo(amount: int) -> void:
	ammo = mini(ammo + amount, data.capacity)
	ammo_changed.emit(ammo, data.capacity)
