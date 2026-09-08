extends Node

signal health_changed(new_value)
signal action_points_changed(new_value)

@export var max_health: int = 80
@export var max_action_points: int = 3

# ========== 当前状态 ==========
var current_health: int = 80:
	set(value):
		current_health = clamp(value, 0, max_health)
		health_changed.emit(current_health) #发布广播
		if current_health <= 0:
			die()

var current_action_points: int = 3:
	set(value):
		current_action_points = clamp(value, 0, max_action_points)
		action_points_changed.emit(current_action_points) #发布广播

# ========== 生命周期 ==========
func _ready():
	# 将自身注册到全局单例，方便其他系统调用
	Global.player = self
	# 初始满状态
	current_health = max_health
	current_action_points = max_action_points
	print("🧑‍🤝‍🧑 玩家已创建！血量: ", current_health, " 行动点: ", current_action_points)

# ========== 核心方法 ==========
func take_damage(damage: int):
	current_health -= damage
	print("💥 玩家受到 ", damage, " 点伤害，剩余血量: ", current_health)

func heal(amount: int):
	current_health += amount
	print("💚 玩家恢复 ", amount, " 点生命，当前血量: ", current_health)

func spend_action_point(cost: int):
	if current_action_points >= cost:
		current_action_points -= cost
		print("⚡ 消耗 ", cost, " 行动点，剩余: ", current_action_points)
		return true
	else:
		print("❌ 行动点不足！")
		return false

func die():
	print("💀 玩家死亡！")
	# 这里后面会连接游戏结束逻辑

func reset_for_battle():
	current_health = max_health
	current_action_points = max_action_points
	print("🔄 玩家已重置，准备战斗！")
