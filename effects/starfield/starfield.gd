extends Node2D
## Fundo estrelado estático, desenhado por código (sem imagens).
## Substitua por um ParallaxBackground / Parallax2D com sua arte depois.

@export var count: int = 150
@export var color: Color = Color(0.55, 0.6, 0.78, 0.8)

var _stars: Array[Vector3] = []   # x, y, tamanho


func _ready() -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = 42                 # semente fixa: o céu é sempre igual
	var area := get_viewport_rect().size
	for i in count:
		_stars.append(Vector3(rng.randf() * area.x, rng.randf() * area.y, rng.randf_range(1.5, 4.0)))
	queue_redraw()


func _draw() -> void:
	for star in _stars:
		draw_rect(Rect2(star.x, star.y, star.z, star.z), color)
