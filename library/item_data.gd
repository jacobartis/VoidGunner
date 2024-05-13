extends Resource
class_name ItemData

@export_category("Basic Info")
@export var item_name: String = "Placeholder"
@export var item_texture: Texture2D
@export var price: int = 100
@export var min_rarity: KnowlageShop.Rarities

func randomize_stats(quality:KnowlageShop.Rarities):
	pass

func apply_to(stats:PlayerStats):
	return
