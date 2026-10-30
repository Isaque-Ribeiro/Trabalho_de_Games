class_name WavePlan
extends Resource
## Toda a "receita" das ondas de UMA fase de nave (era o consts.py do Python).
## Para uma fase nova e mais difícil, duplique um .tres e mude os números.

@export_group("Inimigos")
@export var enemy_scene: PackedScene
@export var enemy_data: EnemyData
@export var enemy_bullet_scene: PackedScene

@export_group("Tamanho das ondas")
@export var first_size: int = 5           # 5, 6, 7, 8, 9, 10 ...
@export var size_step: int = 1
@export var max_size: int = 10            # vencer a onda deste tamanho termina a fase
@export var intermission: float = 2.2     # pausa entre ondas (segundos)

@export_group("Formação")
@export var enemies_per_row: int = 5
@export var formation_top: float = 150.0
@export var spacing: Vector2 = Vector2(180, 110)
@export var side_margin: float = 60.0
@export var drop: float = 50.0            # quanto desce ao bater na borda

@export_group("Velocidade")
@export var base_speed: float = 130.0
@export var speed_per_wave: float = 22.0
@export var speedup_max: float = 130.0    # bônus conforme as naves morrem

@export_group("Tiro inimigo")
@export var fire_base_interval: float = 1.6
@export var fire_step_per_wave: float = 0.15
@export var fire_min_interval: float = 0.6
