class_name LevelBase
extends Node2D
## O "contrato" de TODA fase, seja de nave ou de plataforma.
##
## A fase soma pontos e, quando termina, chama complete_level() ou fail_level().
## O SceneManager escuta esses avisos e decide o que vem depois; por isso uma fase
## nova (qualquer gênero) nunca precisa mexer no resto do jogo.

signal score_changed(score: int)

var score: int = 0


func _ready() -> void:
	get_tree().paused = false     # garante que não herdamos uma pausa anterior


func add_score(points: int) -> void:
	score += points
	score_changed.emit(score)


func complete_level() -> void:
	EventBus.level_completed.emit(score)


func fail_level() -> void:
	EventBus.level_failed.emit(score)
