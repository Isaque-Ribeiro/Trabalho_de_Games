class_name Enemy
extends Node2D
## Uma nave inimiga. Só cuida de si mesma: vida, piscar, barra de vida, morte.
## Quem MOVE a formação e decide quem atira é o WaveManager.

signal died(enemy: Enemy)

@export var data: EnemyData

@onready var _health: HealthComponent = $HealthComponent
@onready var _visual: Node = $Visual


func _ready() -> void:
	_health.reset(data.max_hp)
	_health.damaged.connect(_on_damaged)
	_health.died.connect(_on_died)
	_refresh_visual()


func half_size() -> Vector2:
	return data.size / 2.0


func _on_damaged(_amount: int) -> void:
	_flash()
	_refresh_visual()
	queue_redraw()


func _on_died() -> void:
	# Ordem importa: primeiro o aviso global (pontos, míssil, explosão)...
	EventBus.enemy_killed.emit(global_position, data.score_value)
	# ...depois o aviso local (o WaveManager checa se a onda acabou).
	died.emit(self)
	queue_free()


## Cor do preenchimento vai de "saudável" (verde-petróleo) a "quase morta" (vermelho).
func _refresh_visual() -> void:
	var shape_visual := _visual as ShapeVisual
	if shape_visual == null:
		return   # quando for sprite, aqui entraria troca de frame/animação
	var ratio := float(_health.current) / float(_health.max_health)
	shape_visual.fill_color = Color(0.55, 0.13, 0.15).lerp(Color(0.11, 0.30, 0.28), ratio)


func _flash() -> void:
	var shape_visual := _visual as ShapeVisual
	if shape_visual != null:
		shape_visual.flash(0.08)
	else:
		# Fallback para Sprite2D: clareia e volta ao normal.
		(_visual as CanvasItem).modulate = Color(2, 2, 2)
		create_tween().tween_property(_visual, "modulate", Color.WHITE, 0.1)


func _draw() -> void:
	# Barrinha de vida acima da nave.
	if _health == null:
		return
	var width := data.size.x
	var top := -data.size.y / 2.0 - 18.0
	var ratio := float(_health.current) / float(_health.max_health)
	draw_rect(Rect2(-width / 2.0, top, width, 7.0), Color(0, 0, 0, 0.55))
	draw_rect(Rect2(-width / 2.0, top, width * ratio, 7.0), Color(0.55, 0.85, 0.6))
