extends Node
## GameState (autoload) - só o que SOBREVIVE entre fases.
##
## Regra do projeto: cada fase começa do zero (munição, mísseis, vidas).
## Fica aqui apenas a pontuação acumulada da campanha e o índice da fase.

var total_score: int = 0
var level_index: int = 0


func reset_run() -> void:
	total_score = 0
	level_index = 0
