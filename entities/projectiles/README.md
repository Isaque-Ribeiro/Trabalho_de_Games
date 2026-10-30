# entities/projectiles
Um script (`projectile.gd`, Area2D) e quatro cenas que só mudam números e visual:

| Cena | Layer | Mask | Velocidade | Dano |
|---|---|---|---|---|
| `bullet.tscn` (tiro da nave) | 4 | 3 (enemy) | 1100 | 1 |
| `missile.tscn` | 4 | 3 | 800 | 999 (morte imediata) |
| `laser_bolt.tscn` (astronauta) | 4 | 3 | 1500 | 1 |
| `enemy_bullet.tscn` | 5 | 2 (player) | 480 | 1 (grupo `enemy_projectiles`) |

## Árvore de nós (igual para todas)
```
Bullet (Area2D)              projectile.gd | Speed / Damage / Direction no Inspector
├─ Visual (Node2D)           shape_visual.gd
└─ CollisionShape2D          retângulo pequeno
```
`Projectile.spawn(cena, tree, posicao, direcao)` cria e gira o projétil. O desenho aponta para CIMA;
o script gira conforme a direção (por isso o laser do astronauta funciona na horizontal).

## Novo projétil
Duplique `bullet.tscn`, mude velocidade, dano, forma e crie um `WeaponData` que aponte para ele.
