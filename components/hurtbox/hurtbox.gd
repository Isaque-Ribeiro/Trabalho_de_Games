class_name Hurtbox
extends Area2D
## "Zona que recebe dano". Projéteis e golpes só enxergam Hurtboxes.
##
## O dono (nave, inimigo, herói) tem um Hurtbox ligado ao seu HealthComponent.
## Defina a collision_layer do Hurtbox como a "facção" do dono
## (player = 2, enemy = 3) e deixe collision_mask = 0.

signal hit(damage: int)

@export var health: HealthComponent
## Desligue para ficar "intocável" (ex.: piscando após levar dano).
@export var enabled: bool = true


## Devolve true se o golpe foi aceito (o projétil só some se for aceito).
func receive_hit(damage: int) -> bool:
	if not enabled:
		return false
	if health != null and health.is_dead():
		return false
	hit.emit(damage)
	if health != null:
		health.take_damage(damage)
	return true
