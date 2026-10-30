class_name PlayerPlatformer
extends CharacterBody2D
## Astronauta das fases de plataforma. Reaproveita os MESMOS componentes da nave
## (HealthComponent, Hurtbox, WeaponComponent). Armas: laser (horizontal) e lança.
##
## Controles: A/D ou setas = andar | ESPAÇO/W/↑ = pular | J = laser | K = lança | R = recarregar

signal died

@export var speed: float = 520.0
@export var jump_velocity: float = -900.0
@export var gravity: float = 2200.0
@export var spear_damage: int = 2
@export var spear_duration: float = 0.15
@export var spear_reach: float = 85.0
@export var muzzle_reach: float = 60.0

@onready var laser: WeaponComponent = $LaserGun
@onready var health: HealthComponent = $HealthComponent
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var _muzzle: Marker2D = $Muzzle
@onready var _spear: Area2D = $SpearHitbox
@onready var _spear_visual: CanvasItem = $SpearHitbox/Visual
@onready var _visual: Node2D = $Visual

var _facing: float = 1.0
var _spear_left: float = 0.0
var _alive: bool = true


func _ready() -> void:
	_spear.area_entered.connect(_on_spear_area_entered)
	_spear_visual.visible = false
	health.died.connect(_on_died)


func _physics_process(delta: float) -> void:
	if not _alive:
		return
	if not is_on_floor():
		velocity.y += gravity * delta

	var axis := Input.get_axis(&"move_left", &"move_right")
	velocity.x = axis * speed
	if axis != 0.0:
		_facing = signf(axis)
		_visual.scale.x = _facing           # espelha o desenho
		_muzzle.position.x = muzzle_reach * _facing

	if Input.is_action_just_pressed(&"jump") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
	_handle_attacks(delta)


func _handle_attacks(delta: float) -> void:
	if Input.is_action_pressed(&"attack_laser"):
		laser.try_fire(_muzzle.global_position, Vector2(_facing, 0.0))
	if Input.is_action_just_pressed(&"reload"):
		laser.start_reload()
	if Input.is_action_just_pressed(&"attack_spear") and _spear_left <= 0.0:
		_spear_left = spear_duration
		_spear.position.x = spear_reach * _facing
		_spear.scale.x = _facing
		_spear.monitoring = true
		_spear_visual.visible = true
	if _spear_left > 0.0:
		_spear_left -= delta
		if _spear_left <= 0.0:
			_spear.monitoring = false
			_spear_visual.visible = false


func _on_spear_area_entered(area: Area2D) -> void:
	var target := area as Hurtbox
	if target != null:
		target.receive_hit(spear_damage)


func _on_died() -> void:
	_alive = false
	hurtbox.enabled = false
	hide()
	died.emit()
