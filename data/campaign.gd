class_name Campaign
extends RefCounted
## A ORDEM das fases. Para adicionar uma fase: crie a cena, crie um
## LevelData (.tres) apontando para ela e acrescente o caminho aqui.

const LEVELS: Array[String] = [
	"res://data/levels/level_01.tres",
	"res://data/levels/level_02.tres",
]


static func count() -> int:
	return LEVELS.size()


static func get_level(index: int) -> LevelData:
	return load(LEVELS[index]) as LevelData
