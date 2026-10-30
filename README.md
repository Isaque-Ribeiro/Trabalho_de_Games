# Invasores (Godot 4.7.2) - base escalável

Port do jogo em Python/pygame para Godot, com a arquitetura pensada para várias fases
(nave e plataforma). Visual provisório em polígonos; a arte final entra depois sem mexer na lógica.

## Como abrir
1. Abra o `Godot_v4.7.2-stable_win64.exe` (a versão **padrão**, GDScript; não a .NET).
2. No Project Manager: **Import** > escolha o arquivo `project.godot` desta pasta > **Import & Edit**.
3. Aperte **F5** (rodar o projeto). A cena principal é o menu. ENTER inicia.

### Se aparecerem erros vermelhos na primeira abertura
- `Could not find type "Enemy"` (ou outro nome): é o cache de classes ainda sendo criado.
  Use **Project > Reload Current Project**. Costuma resolver tudo.
- Erro em uma cena `.tscn` específica: abra o README da pasta dela. Cada um traz a árvore de nós
  e o passo a passo para remontar a cena no editor. Os scripts `.gd` continuam valendo.
  (Este projeto foi escrito sem poder executar o Godot, então pequenos ajustes são esperados.
  Mande a mensagem de erro e corrigimos juntos.)

## Controles
Nave: setas ou A/D mover | ESPAÇO atirar (segurar) | M míssil | R recarregar | P ou ESC pausa
Astronauta (fase de plataforma): A/D andar | ESPAÇO pular | J laser | K lança

## Regras (as mesmas do Python)
- Ondas de 5, 6, 7, 8, 9 e 10 naves. Cada nave aguenta 5 tiros.
- Pente de 7 tiros, recarga automática ao esvaziar (ou R).
- A cada 3 abates: +1 míssil (mata uma nave na hora).
- Perde ao levar 3 tiros ou se as naves chegarem à sua linha.
- Vencer a onda de 10 conclui a fase e abre a próxima (a Fase 2 é mais difícil).
- Cada fase começa do zero (munição, mísseis, vidas). Só a pontuação acumula.

## Mapa: Python -> Godot
| Python | Godot |
|---|---|
| `consts.py` | Resources `.tres` em `data/` (WavePlan, WeaponData, EnemyData) |
| `shapes.py` | `components/shape_visual` (provisório) -> depois Sprite2D |
| `events.py` | `core/event_bus` (autoload com signals) |
| `models.py` | `entities/` (cenas) + `components/` (vida, arma, hurtbox) |
| `wave.py` | `levels/shooter/wave_manager.gd` |
| `effects.py` | `effects/` |
| `hud.py` | `ui/hud` |
| `game.py` | `levels/shooter/shooter_level.gd` + `core/scene_manager` |
| game loop | já é do motor (`_process`, `_physics_process`) |

## Arquitetura em 5 linhas
1. **Cena = módulo.** Quase toda cena roda sozinha com F6.
2. **Dados fora do código.** Números de balanceamento vivem em `.tres`, editáveis no Inspector.
3. **Sinais sobem, chamadas descem.** Filho emite; pai/EventBus escuta.
4. **Componentes** (`HealthComponent`, `Hurtbox`, `WeaponComponent`) servem nave, inimigo e astronauta.
5. **Contrato de fase** (`LevelBase`): toda fase termina com `complete_level()` ou `fail_level()`.

## Camadas de colisão (já nomeadas em Project Settings)
1 world | 2 player | 3 enemy | 4 player_projectile | 5 enemy_projectile
Tiro do jogador: layer 4, mask 3. Tiro inimigo: layer 5, mask 2. Hurtboxes: layer = facção do dono, mask 0.

## Como criar uma fase nova de nave (3 passos)
1. Duplique `data/waves/level_02_waves.tres` e mude os números.
2. Crie uma cena herdada de `levels/shooter/shooter_level.tscn` (Scene > New Inherited Scene) e troque o `plan` do WaveManager.
3. Crie um `LevelData` (.tres) apontando para a cena e acrescente o caminho em `data/campaign.gd`.

## Ordem de leitura sugerida
`core/` > `data/` > `components/` > `entities/` > `levels/shooter/` > `ui/` > `effects/`

## O que já está adiantado para o futuro
- Astronauta com lança e laser (`entities/player_platformer`) e fase de teste (`levels/platformer`), fora da campanha.
- Gancho para chefe em `shooter_level.gd` (`_on_wave_cleared`).
- Contrato `LevelBase` que aceita qualquer gênero.
