extends Node
## SceneManager (autoload) - o "fluxo do jogo": menu -> fase 1 -> fase 2 -> ... -> fim.
##
## As fases NÃO chamam o SceneManager. Elas emitem EventBus.level_completed
## ou EventBus.level_failed, e este script decide o que vem depois.

const MAIN_MENU_SCENE := "res://ui/main_menu/main_menu.tscn"
const END_SCREEN_SCENE := "res://ui/end_screen/end_screen.tscn"

# Texto da tela final (lido por end_screen.gd).
var end_title: String = ""
var end_subtitle: String = ""
var end_color: Color = Color.WHITE


func _ready() -> void:
	EventBus.level_completed.connect(_on_level_completed)
	EventBus.level_failed.connect(_on_level_failed)


func go_to_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU_SCENE)


func start_campaign() -> void:
	GameState.reset_run()
	_load_level(0)


func _load_level(index: int) -> void:
	GameState.level_index = index
	var level_data: LevelData = Campaign.get_level(index)
	get_tree().change_scene_to_packed(level_data.scene)


func _on_level_completed(score: int) -> void:
	GameState.total_score += score
	var next_index := GameState.level_index + 1
	if next_index < Campaign.count():
		_load_level(next_index)   # fase passou: vai direto para a próxima
	else:
		_show_end("VITÓRIA!", GameState.total_score, Color(0.55, 0.9, 0.65))


func _on_level_failed(score: int) -> void:
	_show_end("FIM DE JOGO", GameState.total_score + score, Color(0.92, 0.35, 0.35))


func _show_end(title: String, points: int, color: Color) -> void:
	end_title = title
	end_subtitle = "Pontos: %d    -    ENTER reinicia    -    ESC volta ao menu" % points
	end_color = color
	get_tree().change_scene_to_file(END_SCREEN_SCENE)
