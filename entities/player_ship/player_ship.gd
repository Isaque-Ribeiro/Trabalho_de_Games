class_name PlayerShip
extends Node2D
## A nave jato do jogador (fases de tiro).
## Vidas = HealthComponent. Armas = dois WeaponComponents (canhão e míssil).

signal died

@export var speed: float = 700.0
@export var half_width: float = 45.0
@export var half_height: float = 32.0
@export var invulnerability_time: float = 1.5
## A fase desliga isto entre ondas (a nave ainda pode se mover).
var can_shoot: bool = true

@onready var cannon: WeaponComponent = $Cannon
@onready var missile_launcher: WeaponComponent = $MissileLauncher
@onready var health: HealthComponent = $HealthComponent
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var _muzzle: Marker2D = $Muzzle
@onready var _visual: CanvasItem = $Visual

var _invulnerable_left: float = 0.0
var _alive: bool = true


func _ready() -> void:
	health.damaged.connect(_on_damaged)
	health.died.connect(_on_died)


func _process(delta: float) -> void:
	if not _alive:
		return
	_handle_movement(delta)
	_handle_weapons()
	_update_invulnerability(delta)


## Y do topo da nave: a fase usa como "linha de defesa" contra a invasão.
func top_y() -> float:
	return global_position.y - half_height


func _handle_movement(delta: float) -> void:
	var axis := Input.get_axis(&"move_left", &"move_right")
	position.x += axis * speed * delta
	var screen_width := get_viewport_rect().size.x
	position.x = clampf(position.x, half_width, screen_width - half_width)


func _handle_weapons() -> void:
	if not can_shoot:
		return
	if Input.is_action_pressed(&"shoot"):                 # segurar = rajada (cooldown limita)
		cannon.try_fire(_muzzle.global_position, Vector2.UP)
	if Input.is_action_just_pressed(&"missile"):          # apertar = 1 míssil
		missile_launcher.try_fire(_muzzle.global_position, Vector2.UP)
	if Input.is_action_just_pressed(&"reload"):
		cannon.start_reload()


func _update_invulnerability(delta: float) -> void:
	if _invulnerable_left <= 0.0:
		return
	_invulnerable_left -= delta
	_visual.visible = int(_invulnerable_left * 10.0) % 2 == 1   # pisca 5x por segundo
	if _invulnerable_left <= 0.0:
		_visual.visible = true
		hurtbox.enabled = true


func _on_damaged(_amount: int) -> void:
	_invulnerable_left = invulnerability_time
	hurtbox.enabled = false
	EventBus.player_hit.emit(global_position)


func _on_died() -> void:
	_alive = false
	hurtbox.enabled = false
	hide()
	died.emit()
