# components/health
`HealthComponent` (Node): pontos de vida, sinais `damaged`, `health_changed`, `died`.
Nave (3 = vidas), inimigo (5 = HP) e astronauta usam o mesmo componente.

**Sem cena própria.** Use assim: Add Child Node > Node > Attach Script > `health_component.gd`.
Defina `max_health` no Inspector.
Quem ouve `died` decide o que fazer (explodir, game over...). O componente não sabe.
