# levels/platformer
Esqueleto de fase de plataforma (`platformer_level.gd` + `.tscn`). Fora da campanha por enquanto.

## Árvore de nós
```
PlatformerLevel (Node2D)     platformer_level.gd (herda LevelBase)
├─ Projectiles (Node2D)      grupo "projectile_container"
├─ Floor (StaticBody2D)      pos (960, 1050) | layer 1 (world) | mask 0
│   ├─ CollisionShape2D      retângulo 4000x60
│   └─ Visual (Node2D)       shape_visual.gd (retângulo)
├─ PlayerPlatformer          instância de entities/player_platformer
│   └─ Camera2D              filho do herói; Position Smoothing ligado
└─ PauseMenu                 instância de ui/pause_menu
```
## Testar: abra a cena e aperte F6.

## Para virar uma fase de verdade
1. Troque o chão por TileMapLayer + plataformas (StaticBody2D, layer 1).
2. Crie um chefe reusando `HealthComponent` + `Hurtbox` (layer 3) + `Enemy`-like script.
3. Em `platformer_level.gd`: `boss.died.connect(complete_level)`.
4. Crie `LevelData` + entrada em `data/campaign.gd`.
5. Crie um HUD próprio (o `Hud` atual espera uma `PlayerShip`).
