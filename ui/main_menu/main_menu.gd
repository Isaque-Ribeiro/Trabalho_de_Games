extends Control
## Menu principal, o mais simples possível. ENTER/ESPAÇO começa; ESC sai.


func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	if event.is_action_pressed(&"ui_accept"):
		SceneManager.start_campaign()
	elif event.is_action_pressed(&"ui_cancel"):
		get_tree().quit()
