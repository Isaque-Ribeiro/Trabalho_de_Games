class_name Projectile
extends Area2D
## Projétil genérico: anda em linha reta e causa dano ao primeiro Hurtbox que tocar.
##
## Quem ele pode acertar é definido pelas COLLISION LAYERS na cena:
##   tiro do jogador:  layer = player_projectile (4), mask = enemy (3)
##   tiro inimigo:     layer = enemy_projectile (5), mask = player (2)

@export var speed: float = 1000.0
@export var damage: int = 1
@export var direction: Vector2 = Vector2.UP

var _spent: bool = false


## Cria um projétil na árvore. Estático: qualquer um pode chamar sem ter referência.
## O projétil vai para um nó do grupo "projectile_container" (se a fase tiver um),
## para não se mover junto com quem atirou.
static func spawn(scene: PackedScene, tree: SceneTree, world_position: Vector2, dir: Vector2) -> Projectile:
	if scene == null:
		return null
	var projectile := scene.instantiate() as Projectile
	var parent: Node = tree.get_first_node_in_group(&"projectile_container")
	if parent == null:
		parent = tree.current_scene
	parent.add_child(projectile)
	projectile.global_position = world_position
	projectile.direction = dir.normalized()
	projectile.rotation = dir.angle() + PI / 2.0   # o desenho aponta para CIMA
	return projectile


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	# Saiu da tela? Remove (senão objetos se acumulam para sempre).
	if not get_viewport_rect().grow(150.0).has_point(global_position):
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if _spent:
		return
	var hurtbox := area as Hurtbox
	if hurtbox != null and hurtbox.receive_hit(damage):
		_spent = true
		queue_free()
