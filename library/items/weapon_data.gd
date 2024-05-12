extends ItemData
class_name WeaponItemData

@export_category("Weapon Info")
@export var weapon_scene: PackedScene

func apply_to(stats:PlayerStats):
	stats.weapon = weapon_scene
