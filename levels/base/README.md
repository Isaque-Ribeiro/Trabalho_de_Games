# levels/base
`LevelBase` (`level_base.gd`): o contrato de toda fase.

Toda fase (nave, plataforma, o que vier) herda dele e:
- soma pontos com `add_score(n)`;
- termina com `complete_level()` (vitória) ou `fail_level()` (derrota).

O `SceneManager` escuta esses avisos e decide o próximo passo. Por isso uma fase nova nunca
mexe no resto do jogo. **Sem cena**; é só o script base.
