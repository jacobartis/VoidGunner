extends Node

enum Types {
	Elixer,
	Spellbook,
	Weapon,
}

enum Rarities{
	Common,
	Rare,
	Epic,
	Legendary
}

var knowlage: int = 0
var player_stats: PlayerStats

func add_knowlage(val):
	knowlage += val
	print(knowlage)

func get_item_data(type:Types):
	var item_data:ItemData
	match type:
		Types.Elixer:
			item_data = preload("res://library/items/test_elixer.tres")
		Types.Spellbook:
			item_data = preload("res://library/items/test_spellbook.tres")
		Types.Weapon:
			item_data = preload("res://library/items/test_weapon.tres")
	return item_data
