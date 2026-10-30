# components/weapon
`WeaponComponent` (Node): munição, cooldown, recarga e disparo. Regras vêm de um `WeaponData` (.tres).

Uso: Add Child Node > Node > anexe `weapon_component.gd` > no Inspector, arraste um
`WeaponData` para o campo `Data`. O dono chama `try_fire(posicao, direcao)`.

Truque do míssil: é um WeaponComponent com `capacity 99`, `starting_ammo 0`, `reloadable false`.
A fase chama `add_ammo(1)` a cada 3 abates.

Sinais: `ammo_changed(ammo, capacity)`, `reload_started`, `reload_finished` (o HUD usa).
