# data/
Números do jogo fora do código (era o `consts.py`). Três tipos de **Resource**:

| Script | O que descreve | Arquivos `.tres` |
|---|---|---|
| `enemy_data.gd` | HP, pontos, tamanho do inimigo | `enemies/triangle.tres` |
| `weapon_data.gd` | pente, recarga, cooldown, projétil | `weapons/ship_cannon.tres`, `ship_missile.tres`, `laser_gun.tres` |
| `wave_plan.gd` | ondas, formação, velocidade, tiro inimigo | `waves/level_01_waves.tres`, `level_02_waves.tres` |
| `level_data.gd` | nome e cena de uma fase | `levels/level_01.tres`, `level_02.tres` |

`campaign.gd` lista a ordem das fases.

## Mexendo nos números
Dê duplo clique em um `.tres` e edite no Inspector. Ex.: `max_hp` do triângulo para 2; `capacity` do canhão para 20.

## Se um .tres der erro ao abrir, recrie no editor
1. FileSystem > botão direito na pasta > **Create New > Resource**.
2. Escolha o tipo (ex.: `WavePlan`), salve com o mesmo nome.
3. Preencha no Inspector os campos que estão listados no script correspondente.
   (Nos campos de cena, como `enemy_scene`, arraste o `.tscn` do FileSystem.)

## Para escalar
Novo inimigo = novo `EnemyData` + (se o visual mudar) nova cena de inimigo.
Nova arma = novo `WeaponData` + nova cena de projétil.
