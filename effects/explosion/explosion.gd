extends CPUParticles2D
## Explosão de partículas "dispare e esqueça": toca uma vez e se remove.


func _ready() -> void:
	emitting = true
	await get_tree().create_timer(lifetime + 0.3).timeout
	queue_free()
