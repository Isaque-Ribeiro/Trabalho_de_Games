extends Control
## Tela de fim (vitória ou derrota). O texto vem do SceneManager.

@onready var _title: Label = %TitleLabel
@onready var _subtitle: Label = %SubtitleLabel


func _ready() -> void:
	_title.text = SceneManager.end_title
	_title.add_theme_color_override(&"font_color", SceneManager.end_color)
	_subtitle.text = SceneManager.end_subtitle


func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo():
		return      # ignora a tecla ESPAÇO ainda "segurada" do jogo
	if event.is_action_pressed(&"ui_accept"):
		SceneManager.start_campaign()
	elif event.is_action_pressed(&"ui_cancel"):
		SceneManager.go_to_menu()
