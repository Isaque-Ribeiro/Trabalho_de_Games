extends Node
## Controls (autoload) - registra as "ações" de teclado por código.
##
## O jogo nunca pergunta "a tecla X foi apertada?", e sim "a ação Y está
## ativa?". Assim dá para remapear teclas num único lugar (aqui).
## Depois você pode migrar para Project > Project Settings > Input Map.

const BINDINGS: Dictionary = {
	&"move_left": [KEY_LEFT, KEY_A],
	&"move_right": [KEY_RIGHT, KEY_D],
	&"move_up": [KEY_UP, KEY_W],
	&"move_down": [KEY_DOWN, KEY_S],
	&"jump": [KEY_SPACE, KEY_W, KEY_UP],
	# Fases de nave
	&"shoot": [KEY_SPACE],
	&"missile": [KEY_M],
	&"reload": [KEY_R],
	# Fases de plataforma
	&"attack_laser": [KEY_J],
	&"attack_spear": [KEY_K],
	# Geral
	&"pause": [KEY_P, KEY_ESCAPE],
}


func _ready() -> void:
	for action in BINDINGS:
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		for keycode in BINDINGS[action]:
			var event := InputEventKey.new()
			event.physical_keycode = keycode as Key
			InputMap.action_add_event(action, event)
