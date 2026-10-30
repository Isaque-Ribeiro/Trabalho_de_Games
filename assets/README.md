# assets/
Coloque aqui a arte final, organizada por tipo:
```
assets/
├─ sprites/   (player, enemies, projectiles)
├─ backgrounds/
├─ audio/     (sfx, music)
├─ fonts/
└─ themes/    (Theme único de UI)
```
## Ao trocar polígonos por desenhos
- Projeto está em 1920x1080 com `stretch mode = canvas_items`: desenhe pensando nessa resolução.
- Estilo desenhado (não pixel art): importe com **Filter = Linear** e mipmaps ligados se for reduzir.
- Substitua o nó `Visual` (ver `components/shape_visual/README.md`).
- Ajuste os retângulos de `CollisionShape2D` ao tamanho do novo desenho.
- Luz e clima: `CanvasModulate` + `PointLight2D` dão o ar sombrio de Hollow Knight.
- Fundo em camadas: `Parallax2D`.
