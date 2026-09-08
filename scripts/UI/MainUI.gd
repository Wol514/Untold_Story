extends Node

#获取组件
@onready var health_label = $HealthLabel
@onready var ap_label = $APLabel
@onready var dmg_btn = $DamageButton
@onready var heal_btn = $HealButton
@onready var ap_btn = $APConsumeBtn
@onready var card_btn = $CardBtn

func _ready():
	# 连接玩家信号
	var player = Global.player
	player.health_changed.connect(_update_health)
	player.action_points_changed.connect(_update_ap)
	# 初始化显示
	_update_health(player.current_health)
	_update_ap(player.current_action_points)
	
	# 绑定按钮点击事件
	dmg_btn.pressed.connect(_on_damage_pressed)
	heal_btn.pressed.connect(_on_heal_pressed)
	ap_btn.pressed.connect(_on_ap_pressed)

func _update_health(value):
	health_label.text = "❤️ 血量: %d / %d" % [value, Global.player.max_health]

func _update_ap(value):
	ap_label.text = "⚡ 行动点: %d / %d" % [value, Global.player.max_action_points]

func _on_damage_pressed():
	Global.player.take_damage(10)

func _on_heal_pressed():
	Global.player.heal(5)

func _on_ap_pressed():
	Global.player.spend_action_point(1)
