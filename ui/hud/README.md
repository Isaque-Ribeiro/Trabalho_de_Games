# ui/hud
`Hud` (CanvasLayer): pontos, onda, vidas, munição, mísseis, avisos ("toasts") e o banner central.
Não tem regra de jogo; a fase chama `set_*` e `bind_player(nave)` liga vidas/munição sozinho.

## Árvore de nós (nomes com % = "Unique Name": clique direito no nó > Access as Unique Name)
```
Hud (CanvasLayer)                 hud.gd | layer 5
└─ Root (Control)                 Full Rect | mouse_filter Ignore
   ├─ Margin (MarginContainer)    Full Rect | margens 40/24/40/24
   │   └─ VBox (VBoxContainer)
   │       ├─ Top (HBoxContainer): %ScoreLabel | %WaveLabel (centro) | %LivesLabel (direita)
   │       ├─ %ToastLabel (Label)
   │       ├─ Spacer (Control)    Size Flags Vertical = Expand
   │       └─ Bottom (HBoxContainer): %AmmoLabel | %MissileLabel (direita)
   └─ %Banner (CenterContainer)   Full Rect | visible OFF
       └─ VBox: %BannerTitle (fonte 110) + %BannerSubtitle
```
Cada Label do `Top`/`Bottom` usa Size Flags Horizontal = Expand para dividir a largura.
Para trocar a fonte: Theme Overrides > Fonts em cada Label, ou crie um Theme único (recomendado).
