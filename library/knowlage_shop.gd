extends Node

signal knowlage_update(val)

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

var items:Dictionary = {
	Types.Weapon: [],
	Types.Elixer: [],
	Types.Spellbook: [],
}

var knowlage: int = 0: set=set_knowlage
var player_stats: PlayerStats

var min_att_mod: float = 0.8
var item_rand = RandomNumberGenerator.new()

func set_knowlage(val):
	knowlage = val
	knowlage_update.emit(knowlage)

func _ready():
	load_items()
	item_rand.seed = randf()

func add_knowlage(val):
	knowlage += val

func get_item_data(type:Types,rarity:Rarities=Rarities.Common):
	var item_data:ItemData = ElixerItemData.new()
	var avalible_items = items[type]
	avalible_items.filter(func(item):return rarity<item.min_rarity)
	if !avalible_items.is_empty():
		item_data = avalible_items[item_rand.randi()%avalible_items.size()]
	return item_data.duplicate(true)

func get_rarity():
	return item_rand.randi()%4

func get_rarity_dist(rarity:Rarities,quant:int=1):
	var stat_total = min_att_mod*(quant)+(rarity*5+1)
	var dist = []
	for x in quant-1:
		if stat_total<=min_att_mod*quant:
			dist.append(min_att_mod)
			stat_total-=min_att_mod
			continue
		var value = snapped(item_rand.randf_range(min_att_mod,stat_total-min_att_mod*(quant-x)),.1)
		dist.append(value)
		stat_total-=value
	dist.append(stat_total)
	return dist

func load_items():
	var dir = "res://library/items/"
	var dir_access = DirAccess.open(dir)
	if dir_access:
		dir_access.list_dir_begin()
		var file_name = "is overwritten"
		while file_name != "":
			file_name = dir_access.get_next()
			if !file_name.ends_with(".tres"):continue
			var item = ResourceLoader.load(dir+file_name,"ItemData")
			items[item.type].append(item)
