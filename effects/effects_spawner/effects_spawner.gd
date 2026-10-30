extends Node
## Escuta o EventBus e cria os efeitos visuais. Nenhuma outra parte do jogo
## sabe que explosões existem: elas só emitem "inimigo morreu" / "jogador levou tiro".

@export var enemy_explosion: PackedScene
@export var player_explosion: PackedScene


func _ready() -> void:
	EventBus.enemy_killed.connect(_on_enemy_killed)
	EventBus.player_hit.connect(_on_player_hit)


func _on_enemy_killed(world_position: Vector2, _points: int) -> void:
	_spawn(enemy_explosion, world_position)


func _on_player_hit(world_position: Vector2) -> void:
	_spawn(player_explosion, world_position)


func _spawn(scene: PackedScene, world_position: Vector2) -> void:
	if scene == null:
		return
	var fx := scene.instantiate() as Node2D
	get_tree().current_scene.add_child(fx)
	fx.global_position = world_position
