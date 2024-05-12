extends Resource
class_name ItemData

@export_category("Basic Info")
@export var item_name: String = "Placeholder"
@export var price: int = 100
@export var min_rarity: KnowlageShop.Rarities

func apply_to(stats:PlayerStats):
	return
