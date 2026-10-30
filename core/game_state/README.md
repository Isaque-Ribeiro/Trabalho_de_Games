# core/game_state (autoload `GameState`)
Guarda só o que sobrevive entre fases: pontuação total e índice da fase.
Munição, mísseis e vidas NÃO ficam aqui (cada fase recomeça do zero).

**Sem cena.** Para salvar progresso em disco no futuro, é aqui que entraria
(`FileAccess` / `ConfigFile`), sem mexer nas fases.
Autoload: nome `GameState`, caminho `res://core/game_state/game_state.gd`.
