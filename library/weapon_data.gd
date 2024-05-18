extends ItemData
class_name WeaponItemData

var type:KnowledgeShop.Types = KnowledgeShop.Types.Weapon
@export_category("Weapon Info")
@export var weapon_scene: PackedScene

func get_printable_stats():
	var arr = super()
	var weapon = weapon_scene.instantiate()
	if !weapon: return arr
	arr.append_array(weapon.get_printable_stats())
	return arr

func randomize_stats(rarity:KnowledgeShop.Rarities):
	match rarity:
		KnowledgeShop.Rarities.Common:
			item_name = "Common "+item_name
		KnowledgeShop.Rarities.Rare:
			item_name = "Rare "+item_name
		KnowledgeShop.Rarities.Epic:
			item_name = "Epic "+item_name
		KnowledgeShop.Rarities.Legendary:
			item_name = "Legendary "+item_name
	price = randi_range(price*(rarity*2+1)*.75,price*(rarity*2+1))
	var packer = PackedScene.new()
	var scene = weapon_scene.instantiate()
	scene.randomize_stats(rarity)
	packer.pack(scene)
	weapon_scene = packer

func apply_to(stats:PlayerStats):
	stats.weapon = self
