# ui/pause_menu
Pausa. P ou ESC alternam `get_tree().paused`.

```
PauseMenu (CanvasLayer)       pause_menu.gd | layer 10 | Process Mode = Always | visible OFF
├─ Dim (ColorRect)            Full Rect | cor preta com alpha 0.55 | mouse_filter Ignore
└─ Center (CenterContainer)   Full Rect
    └─ Label                  "PAUSA", fonte 120
```
Ponto-chave: **Process Mode = Always** faz este nó continuar ouvindo a tecla enquanto o resto congela.
