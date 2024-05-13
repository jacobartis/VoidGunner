extends ItemData
class_name WeaponItemData

var type:KnowlageShop.Types = KnowlageShop.Types.Weapon
@export_category("Weapon Info")
@export var weapon_scene: PackedScene

func randomize_stats(rarity:KnowlageShop.Rarities):
	match rarity:
		KnowlageShop.Rarities.Common:
			item_name = "Common "+item_name
		KnowlageShop.Rarities.Rare:
			item_name = "Rare "+item_name
		KnowlageShop.Rarities.Epic:
			item_name = "Epic "+item_name
		KnowlageShop.Rarities.Legendary:
			item_name = "Legendary "+item_name
	price = randi_range(price*(rarity*2+1)*.75,price*(rarity*2+1))

func apply_to(stats:PlayerStats):
	stats.weapon = self
