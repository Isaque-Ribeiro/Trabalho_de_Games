extends Node
## EventBus (autoload) - quadro de avisos GLOBAL.
##
## Quem faz algo acontecer apenas emite; quem se importa se inscreve.
## Exemplo: Enemy emite enemy_killed -> a fase soma pontos, o EffectsSpawner
## cria a explosão, o HUD pode mostrar um aviso... e o Enemy não conhece ninguém.
## (É o events.py do projeto em Python.)

@warning_ignore("unused_signal")
signal enemy_killed(world_position: Vector2, points: int)
@warning_ignore("unused_signal")
signal player_hit(world_position: Vector2)
@warning_ignore("unused_signal")
signal missile_earned
@warning_ignore("unused_signal")
signal toast_requested(text: String)
@warning_ignore("unused_signal")
signal level_completed(score: int)
@warning_ignore("unused_signal")
signal level_failed(score: int)
