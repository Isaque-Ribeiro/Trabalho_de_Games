class_name WeaponData
extends Resource
## Números de UMA arma. Serve para canhão, míssil, laser do astronauta...
##
## Truque: o míssil é uma arma com capacity alto, starting_ammo = 0 e
## reloadable = false. Ele não recarrega: só ganha munição por recompensa.

@export var display_name: String = "Canhão"
@export var projectile_scene: PackedScene
@export var capacity: int = 7             # tamanho do pente (ou do estoque)
@export var starting_ammo: int = -1       # -1 = começa cheio
@export var reloadable: bool = true
@export var reload_time: float = 1.4
@export var cooldown: float = 0.25        # intervalo mínimo entre tiros
