# core/scene_manager (autoload `SceneManager`)
O fluxo do jogo: menu > fase 1 > fase 2 > ... > tela final.

- `start_campaign()`: zera a campanha e carrega a fase 0.
- Escuta `EventBus.level_completed` (carrega a próxima ou mostra VITÓRIA) e `level_failed` (FIM DE JOGO).
- A lista de fases vem de `data/campaign.gd`.

**Sem cena.** Para adicionar transições (fade) no futuro, crie o efeito aqui, antes do `change_scene_*`.
Autoload: nome `SceneManager`, caminho `res://core/scene_manager/scene_manager.gd`.
