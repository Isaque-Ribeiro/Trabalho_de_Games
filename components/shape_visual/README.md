# components/shape_visual
`ShapeVisual` (Node2D, `@tool`): desenha polígono + contorno por código. Visual PROVISÓRIO.

Editando uma forma: selecione o nó `Visual`, edite `Points` no Inspector (lista de Vector2,
com (0,0) no centro, y negativo = para cima). Muda ao vivo no editor. Também há `Fill Color`,
`Outline Color` e `Outline Width`.

## Trocando por arte desenhada (estilo Hollow Knight)
1. Apague o nó `Visual`.
2. Adicione um **Sprite2D** (ou **AnimatedSprite2D**) com o **mesmo nome `Visual`**.
3. Arraste o PNG para `Texture`. O jogo não precisa de mais nada: nave, inimigo e projétil
   só conhecem o nome "Visual". O piscar ao levar tiro cai no plano B (modulate).
Dica: arte com contorno escuro e preenchimento suave; importe com filtro Linear (não pixel art).
