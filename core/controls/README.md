# core/controls (autoload `Controls`)
Cria as ações de teclado por código (`move_left`, `shoot`, `missile`, `reload`, `jump`,
`attack_laser`, `attack_spear`, `pause`). O jogo só pergunta por ações, nunca por teclas.

Para remapear: edite o dicionário `BINDINGS`.

Migrar para o editor (opcional): Project > Project Settings > **Input Map**, crie as mesmas
ações, adicione as teclas e apague `BINDINGS`. O resto do jogo continua igual.
Autoload: nome `Controls`, caminho `res://core/controls/controls.gd`.
