# components/hurtbox
`Hurtbox` (Area2D): a zona que recebe dano. Projéteis e a lança só enxergam Hurtboxes.

Como montar em qualquer personagem:
1. Add Child Node > **Area2D**, nome `Hurtbox`; anexe `hurtbox.gd`.
2. Filho: **CollisionShape2D** com um retângulo do tamanho do corpo.
3. Inspector do Hurtbox: `Health` = arraste o nó `HealthComponent` irmão.
4. Collision: **Layer** = facção do dono (player = 2, enemy = 3). **Mask** = nada.
5. Desmarque **Monitoring** (o Hurtbox só precisa ser detectado, não detectar).

`enabled = false` deixa o personagem intocável (usado no piscar da nave).
