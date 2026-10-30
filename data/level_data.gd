class_name LevelData
extends Resource
## Descreve UMA fase da campanha. A lista de fases está em campaign.gd.

@export var display_name: String = "Fase"
@export var level_type: String = "shooter"    # "shooter" ou "platformer" (para menus futuros)
@export var scene: PackedScene
