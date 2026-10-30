# ui/end_screen
Tela de vitória/derrota. O texto vem de `SceneManager.end_title/end_subtitle/end_color`.

```
EndScreen (Control)           Full Rect | end_screen.gd
└─ Center (CenterContainer)   Full Rect
   └─ VBox (VBoxContainer)
      ├─ %TitleLabel (Label)       fonte 130   (Access as Unique Name)
      └─ %SubtitleLabel (Label)    fonte 40
```
ENTER reinicia a campanha, ESC volta ao menu. Ignora eco de tecla segurada (senão o ESPAÇO
que você segurava no jogo reiniciava instantaneamente).
