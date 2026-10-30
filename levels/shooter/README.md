# levels/shooter
Fases de nave. `shooter_level.gd` (regras) + `wave_manager.gd` (ondas) + `shooter_level.tscn` (modelo).
`level_01/` e `level_02/` são cenas HERDADAS do modelo, trocando apenas o `plan` (WavePlan).

## Árvore de nós de `shooter_level.tscn`
```
ShooterLevel (Node2D)        shooter_level.gd
├─ Starfield (Node2D)        effects/starfield/starfield.gd
├─ Projectiles (Node2D)      GRUPO "projectile_container" (aba Node > Groups)
├─ WaveManager (Node2D)      wave_manager.gd | pos (0,0) | Plan = data/waves/level_01_waves.tres
├─ PlayerShip                instância de entities/player_ship/player_ship.tscn | pos (960, 990)
├─ EffectsSpawner            instância de effects/effects_spawner/effects_spawner.tscn
├─ Hud                       instância de ui/hud/hud.tscn
└─ PauseMenu                 instância de ui/pause_menu/pause_menu.tscn
```
(Instanciar uma cena: arraste o `.tscn` do FileSystem para dentro da árvore, ou Ctrl+Shift+A.)

## Cena herdada (nova fase)
Scene > **New Inherited Scene** > escolha `shooter_level.tscn`. Selecione `WaveManager`, troque `Plan`
por outro `.tres` e salve em `levels/shooter/level_03/level_03.tscn`.

## Fluxo da fase
INTERMISSION (banner "ONDA n") > PLAYING > onda limpa > nova intermission ... > onda final limpa >
"FASE CONCLUÍDA" > `complete_level()`.
Perde se as vidas acabarem ou se uma nave chegar ao topo da nave jogadora.

## Gancho de chefe
Em `_on_wave_cleared()`, quando `was_final` for true, instancie o chefe e só chame `_win()` quando ele morrer.
