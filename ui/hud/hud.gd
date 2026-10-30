class_name Hud
extends CanvasLayer
## Interface em jogo. Só MOSTRA valores: não tem regra de jogo.
## A fase chama os métodos set_*; bind_player() liga vidas/munição sozinho.

@onready var _score: Label = %ScoreLabel
@onready var _wave: Label = %WaveLabel
@onready var _lives: Label = %LivesLabel
@onready var _toast: Label = %ToastLabel
@onready var _ammo: Label = %AmmoLabel
@onready var _missiles: Label = %MissileLabel
@onready var _banner: Control = %Banner
@onready var _banner_title: Label = %BannerTitle
@onready var _banner_subtitle: Label = %BannerSubtitle

var _player: PlayerShip
var _toast_left: float = 0.0
var _ammo_count: int = 0
var _ammo_capacity: int = 0
var _missile_count: int = 0
var _kill_progress: int = 0
var _kill_goal: int = 3


func _ready() -> void:
	EventBus.missile_earned.connect(_on_missile_earned)
	EventBus.toast_requested.connect(toast)
	_toast.text = ""
	hide_banner()


func _process(delta: float) -> void:
	if _toast_left > 0.0:
		_toast_left -= delta
		if _toast_left <= 0.0:
			_toast.text = ""
	# A recarga muda a cada quadro, então lemos o progresso daqui.
	if _player != null and _player.cannon.is_reloading:
		_ammo.text = "RECARREGANDO %d%%" % roundi(_player.cannon.reload_progress * 100.0)
	else:
		_ammo.text = "TIROS %d/%d" % [_ammo_count, _ammo_capacity]


## Liga o HUD à nave: ouve vidas, munição e mísseis.
func bind_player(player: PlayerShip) -> void:
	_player = player
	player.health.health_changed.connect(_on_lives_changed)
	player.cannon.ammo_changed.connect(set_ammo)
	player.missile_launcher.ammo_changed.connect(_on_missiles_changed)
	set_lives(player.health.current)
	set_ammo(player.cannon.ammo, player.cannon.data.capacity)
	set_missiles(player.missile_launcher.ammo)


func set_score(value: int) -> void:
	_score.text = "PONTOS %d" % value


func set_wave(number: int, total: int) -> void:
	_wave.text = "ONDA %d/%d" % [number, total]


func set_lives(value: int) -> void:
	_lives.text = "VIDAS %d" % value


func set_ammo(ammo: int, capacity: int) -> void:
	_ammo_count = ammo
	_ammo_capacity = capacity


func set_missiles(count: int) -> void:
	_missile_count = count
	_refresh_missile_label()


func set_kill_progress(progress: int, goal: int) -> void:
	_kill_progress = progress
	_kill_goal = goal
	_refresh_missile_label()


func toast(text: String) -> void:
	_toast.text = text
	_toast_left = 1.6


func show_banner(title: String, subtitle: String = "", color: Color = Color.WHITE) -> void:
	_banner_title.text = title
	_banner_title.add_theme_color_override(&"font_color", color)
	_banner_subtitle.text = subtitle
	_banner.visible = true


func hide_banner() -> void:
	_banner.visible = false


func _refresh_missile_label() -> void:
	_missiles.text = "MÍSSEIS x%d   (próximo: %d/%d abates)" % [_missile_count, _kill_progress, _kill_goal]


func _on_lives_changed(current: int, _maximum: int) -> void:
	set_lives(current)


func _on_missiles_changed(ammo: int, _capacity: int) -> void:
	set_missiles(ammo)


func _on_missile_earned() -> void:
	toast("+1 MÍSSIL!")
