@tool
class_name ShapeVisual
extends Node2D
## Visual PROVISÓRIO: polígono preenchido + contorno (estilo "desenho").
##
## Quando você tiver a arte pronta, apague este nó e coloque no lugar um
## Sprite2D / AnimatedSprite2D com o MESMO nome ("Visual"). O resto do jogo
## só conhece o nome "Visual" e não depende deste script.

@export var points: PackedVector2Array = PackedVector2Array([
	Vector2(-30, 30), Vector2(30, 30), Vector2(0, -30)]):
	set(value):
		points = value
		queue_redraw()

@export var fill_color: Color = Color(0.12, 0.17, 0.22):
	set(value):
		fill_color = value
		queue_redraw()

@export var outline_color: Color = Color(0.85, 0.92, 0.95):
	set(value):
		outline_color = value
		queue_redraw()

@export var outline_width: float = 3.0:
	set(value):
		outline_width = value
		queue_redraw()

var _flash_left: float = 0.0


func _ready() -> void:
	set_process(false)


## Pisca em branco por alguns instantes ("acertei!").
func flash(duration: float = 0.08) -> void:
	_flash_left = duration
	set_process(true)
	queue_redraw()


func _process(delta: float) -> void:
	_flash_left -= delta
	if _flash_left <= 0.0:
		_flash_left = 0.0
		set_process(false)
		queue_redraw()


func _draw() -> void:
	if points.size() < 3:
		return
	var fill := Color.WHITE if _flash_left > 0.0 else fill_color
	draw_colored_polygon(points, fill)
	var closed := points.duplicate()
	closed.append(points[0])
	draw_polyline(closed, outline_color, outline_width, true)
