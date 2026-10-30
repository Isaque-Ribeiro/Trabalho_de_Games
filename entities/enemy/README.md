# entities/enemy
Uma nave inimiga. `Enemy` (Node2D). Cuida de vida, piscar, barra de vida e morte.
Quem a move e a faz atirar é o `WaveManager`.

## Árvore de nós
```
Enemy (Node2D)               enemy.gd | Data = data/enemies/triangle.tres
├─ Visual (Node2D)           shape_visual.gd | Points: (-40,-34) (40,-34) (0,34)  ← triângulo
├─ HealthComponent (Node)
└─ Hurtbox (Area2D)          layer 3 (enemy) | mask 0 | monitoring OFF | Health = ../HealthComponent
    └─ CollisionShape2D      retângulo 70x56
```
## Trocar a forma da nave
Selecione `Visual` e edite `Points`. Para um inimigo novo (ex.: diamante com 8 de vida):
duplique a cena (Scene > Save As), mude `Points` e crie outro `EnemyData`.
Depois aponte o `enemy_scene` do WavePlan para a nova cena.

## Morte
Emite `EventBus.enemy_killed` (pontos, míssil, explosão) e depois o sinal local `died`.
