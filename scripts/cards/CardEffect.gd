# scripts/cards/CardEffect.gd
extends Resource
class_name CardEffect

# ========== 效果参数 ==========
enum Target { SELF, ENEMY, ALL_ENEMIES }
enum EffectType { DAMAGE, BLOCK, APPLY_BUFF, DRAW, HEAL, EXHAUST }
enum BuffType { FOCUS, VULNERABLE, WEAK, STRENGTH }

@export var effect_type: EffectType = EffectType.DAMAGE
@export var target: Target = Target.ENEMY
@export var base_value: float = 0

# ========== 特殊参数 ==========
@export var buff_type: BuffType = BuffType.FOCUS
@export var buff_amount: float = 0

@export var is_multi_hit: bool = false
@export var hit_count: int = 1

@export var is_exhaust: bool = false  # 使用后是否消耗
@export var draw_count: int = 0       # 抽牌数量（如果效果是抽牌）
