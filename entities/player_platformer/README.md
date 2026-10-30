# entities/player_platformer
O astronauta das fases de plataforma. `PlayerPlatformer` (CharacterBody2D): anda, pula,
atira laser (horizontal) e golpeia com lança. Usa os mesmos componentes da nave.

## Árvore de nós
```
PlayerPlatformer (CharacterBody2D)  player_platformer.gd | layer 2 | mask 1 (world)
├─ CollisionShape2D          retângulo 50x100 (corpo físico)
├─ Visual (Node2D)           shape_visual.gd (placeholder de astronauta)
├─ Muzzle (Marker2D)         pos (60, -5)
├─ HealthComponent (Node)    max_health = 5
├─ Hurtbox (Area2D)          layer 2 | mask 0 | monitoring OFF | Health = ../HealthComponent
│   └─ CollisionShape2D
├─ LaserGun (Node)           weapon_component.gd | Data = data/weapons/laser_gun.tres
└─ SpearHitbox (Area2D)      layer 0 | mask 3 (enemy) | monitoring OFF | monitorable OFF
    ├─ CollisionShape2D      retângulo 90x24
    └─ Visual (Node2D)       só aparece durante o golpe
```
## Testar
Abra `levels/platformer/platformer_level.tscn` e aperte F6. (Sozinha, a cena não tem chão e cai.)

## Para escalar
- Armas novas: crie outro `WeaponData` e outro nó `WeaponComponent`.
- Animações: troque `Visual` por AnimatedSprite2D (ver `components/shape_visual/README.md`).
- Pulo duplo, dash e coyote time: acrescente em `_physics_process`.
