# effects/effects_spawner
Escuta o EventBus e cria os efeitos. Ninguém mais sabe que explosões existem.

```
EffectsSpawner (Node)         effects_spawner.gd
  Enemy Explosion  = effects/explosion/explosion_enemy.tscn
  Player Explosion = effects/explosion/explosion_player.tscn
```
Para novos efeitos (som, tremor de tela): acrescente `@export` e conecte outro sinal do EventBus aqui.
