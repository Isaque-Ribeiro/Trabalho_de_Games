class_name HealthComponent
extends Node
## Pontos de vida reutilizável. Serve para inimigo, nave, astronauta, chefe.
## Vida da nave = "vidas" (cada tiro tira 1). Vida do inimigo = HP (cada tiro tira 1).

signal health_changed(current: int, maximum: int)
signal damaged(amount: int)
signal died

@export var max_health: int = 5

var current: int = 0


func _ready() -> void:
	current = max_health


## Define um novo máximo e enche a vida (usado quando um EnemyData é aplicado).
func reset(new_max: int) -> void:
	max_health = new_max
	current = new_max
	health_changed.emit(current, max_health)


func take_damage(amount: int) -> void:
	if current <= 0:
		return
	current = maxi(0, current - amount)
	damaged.emit(amount)
	health_changed.emit(current, max_health)
	if current == 0:
		died.emit()


func is_dead() -> bool:
	return current <= 0
