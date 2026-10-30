# entities/player_ship
A nave jato. `PlayerShip` (Node2D).

## Árvore de nós
```
PlayerShip (Node2D)            script: player_ship.gd
├─ Visual (Node2D)             script: shape_visual.gd  (forma de jato)
├─ Muzzle (Marker2D)           pos (0, -40)  ← de onde saem os tiros
├─ HealthComponent (Node)      max_health = 3  (as 3 vidas)
├─ Hurtbox (Area2D)            hurtbox.gd | layer 2 | mask 0 | monitoring OFF | Health = ../HealthComponent
│   └─ CollisionShape2D        retângulo 60x50
├─ Cannon (Node)               weapon_component.gd | Data = data/weapons/ship_cannon.tres
└─ MissileLauncher (Node)      weapon_component.gd | Data = data/weapons/ship_missile.tres
```
## Como montar se o .tscn der erro
Scene > New Scene > Other Node > Node2D, renomeie, salve como `player_ship.tscn`, anexe o script e
adicione os filhos acima (Ctrl+A). Os componentes ficam em `components/`.

## Testar sozinha
Abra a cena e aperte **F6**: setas movem, ESPAÇO atira (os tiros somem sem alvo).
Para os tiros não "grudarem" na nave, teste dentro de uma fase (que tem o nó `Projectiles`).
