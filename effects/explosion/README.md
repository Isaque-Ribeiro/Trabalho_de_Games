# effects/explosion
Explosão de partículas "dispare e esqueça". `explosion.gd` toca e remove o nó.

`explosion_enemy.tscn` (laranja) e `explosion_player.tscn` (ciano):
```
ExplosionEnemy (CPUParticles2D)   explosion.gd
  Emitting OFF | One Shot ON | Amount 26 | Lifetime 0.6 | Explosiveness 1.0
  Direction (0,-1) | Spread 180 | Gravity (0,0)
  Initial Velocity 100..380 | Scale Amount 4..10 | Color laranja
```
Para uma explosão desenhada, troque por um `AnimatedSprite2D` e remova-se em `animation_finished`.
