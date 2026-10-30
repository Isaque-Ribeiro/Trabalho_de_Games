class_name PlatformerLevel
extends LevelBase
## Fase de plataforma (esqueleto). Segue o MESMO contrato da LevelBase:
## quando o chefe morrer, chame complete_level(); se o herói morrer, fail_level().
##
## Ainda não está na campanha (data/campaign.gd). Teste com F6.

@onready var _hero: PlayerPlatformer = $PlayerPlatformer


func _ready() -> void:
	super()
	_hero.died.connect(_on_hero_died)
	# TODO (chefe): quando existir um Boss, faça  boss.died.connect(complete_level)


func _on_hero_died() -> void:
	await get_tree().create_timer(1.5).timeout
	fail_level()
