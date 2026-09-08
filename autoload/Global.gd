extends Node

var player = null

#预加载卡牌库
var card_library: Dictionary = {}          # 按卡名索引
var card_list: Array[CardData] = []       # 所有卡牌列表（便于遍历）

func _ready() -> void:
	load_card_library()
	print("已加载卡牌库")
	pass # Replace with function body.

func load_card_library():
	card_library.clear()
	card_list.clear()
	
	var root_path = "res://resources/cards/"
	var dir = DirAccess.open(root_path)

	if not dir:
		push_error("❌ 无法打开卡牌目录：", root_path)
		return
	
	# 递归遍历所有子目录
	_scan_directory(dir, root_path)
	
	if card_library.is_empty():
		push_warning("⚠️ 没有加载到任何卡牌！请检查 resources/cards/ 目录")
	else:
		print("✅ 卡牌库加载完成，共 ", card_library.size(), " 张卡牌")

# 递归扫描目录
func _scan_directory(dir: DirAccess, path: String):
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		var full_path = path + file_name
		
		if dir.current_is_dir() and file_name != "." and file_name != "..":
			# 递归进入子文件夹
			var sub_dir = DirAccess.open(full_path + "/")
			if sub_dir:
				_scan_directory(sub_dir, full_path + "/")
		elif file_name.ends_with(".tres") or file_name.ends_with(".res"):
			# 尝试加载资源
			var card = _load_card(full_path)
			if card:
				card_library[card.card_name] = card
				card_list.append(card)
		
		file_name = dir.get_next()
	
	dir.list_dir_end()

# 加载单张卡牌，带错误处理
func _load_card(path: String) -> CardData:
	var resource = load(path)
	if resource == null:
		push_warning("⚠️ 无法加载卡牌文件：", path)
		return null
	
	if not (resource is CardData):
		push_warning("⚠️ 文件不是 CardData 类型：", path)
		return null
	
	var card = resource as CardData
	if card.card_name.is_empty():
		push_warning("⚠️ 卡牌名称为空：", path)
		return null
	
	print("✅ 加载卡牌: ", card.card_name, " (", path, ")")
	return card

# ========== 便捷查询方法 ==========
func get_card(name: String) -> CardData:
	return card_library.get(name, null)

func get_cards_by_type(card_type: int) -> Array[CardData]:
	var result: Array[CardData] = []
	for card in card_list:
		if card.card_type == card_type:
			result.append(card)
	return result

func get_cards_by_rarity(rarity: int) -> Array[CardData]:
	var result: Array[CardData] = []
	for card in card_list:
		if card.rarity == rarity:
			result.append(card)
	return result

# ========== 热重载（开发用） ==========
func reload_card_library():
	print("🔄 重新加载卡牌库...")
	load_card_library()
	# 如果 Deck 已初始化，可以重新初始化牌组（需额外逻辑，这里不做）
	# 但你可以手动调用 Global.deck.initialize_deck() 来更新牌组
