extends Node2D

signal item_selected(item)

@export var item_type: KnowledgeShop.Types
@export var override_rarity: bool = false
@export var override_value: KnowledgeShop.Rarities

var rarity
var item: set=set_item

func set_item(new_item):
	if item:
		item.queue_free()
	add_child(new_item)
	new_item.selected.connect(on_item_selected)
	new_item.global_position = global_position
	item = new_item

func spawn_item():
	if override_rarity: rarity = override_value
	else: rarity = KnowledgeShop.get_rarity()
	item = preload("res://library/item.tscn").instantiate()
	var item_data = KnowledgeShop.get_item_data(item_type,rarity)
	if override_rarity:
		item_data.randomize_stats(override_value)
	else:
		item_data.randomize_stats(rarity)
	item.item_data = item_data

func on_item_selected():
	item_selected.emit(item)
