extends Resource
class_name CardData

# ========== 卡牌基本信息 ==========
@export var card_name: String = "未命名"
@export_multiline var description: String = "描述文字"
@export var action_point_cost: int = 1

# ========== 卡牌类型 ==========
enum CardType { ATTACK, DEFENSE, SKILL }
@export var card_type: CardType = CardType.ATTACK

enum Rarity { BASIC, COMMON, RARE , EPIC}
@export var rarity: Rarity = Rarity.BASIC

# ========== 美术 ==========
@export var texture: Texture2D
	
# ========== 效果数据 ==========	
@export var effect: CardEffect  # 引用另一个 Resource
