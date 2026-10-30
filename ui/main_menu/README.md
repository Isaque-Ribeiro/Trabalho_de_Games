# ui/main_menu
Menu inicial mínimo. Cena principal do projeto (Project Settings > Application > Run > Main Scene).

```
MainMenu (Control)            Full Rect | main_menu.gd
└─ Center (CenterContainer)   Full Rect
   └─ VBox (VBoxContainer)    separation 24
      ├─ Title (Label)        fonte 150
      ├─ Start (Label)        fonte 48
      └─ Help (Label)         fonte 30
```
ENTER/ESPAÇO inicia (`SceneManager.start_campaign()`), ESC sai.
Para botões clicáveis (mouse), troque os Labels por `Button` e conecte o sinal `pressed`.
