class_name EnemyData
extends Resource
## Números de UM tipo de inimigo. Crie arquivos .tres a partir deste script
## (botão direito > New Resource > EnemyData) para novos tipos de nave.

@export var display_name: String = "Triângulo"
@export var max_hp: int = 5               # tiros necessários para derrubar
@export var score_value: int = 100        # multiplicado pelo número da onda
@export var size: Vector2 = Vector2(80, 70)   # usado no layout e nas bordas da formação
