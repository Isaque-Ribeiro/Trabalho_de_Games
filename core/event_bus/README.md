# core/event_bus (autoload `EventBus`)
Quadro de avisos global (padrão Observer). É o `events.py` do Python.

**Sem cena.** Só script. Está registrado em Project Settings > Globals > Autoload.

Sinais: `enemy_killed`, `player_hit`, `missile_earned`, `toast_requested`, `level_completed`, `level_failed`.

Como usar:
- Emitir: `EventBus.enemy_killed.emit(posicao, pontos)`
- Escutar: `EventBus.enemy_killed.connect(minha_funcao)`

Regra: coloque aqui só eventos que mais de um sistema precisa ouvir. Sinais "locais"
(ex.: `died` do Enemy) ficam no próprio nó.

Se o autoload sumir: Project > Project Settings > Globals > Autoload > Add, caminho
`res://core/event_bus/event_bus.gd`, nome `EventBus`, marque "Enable".
