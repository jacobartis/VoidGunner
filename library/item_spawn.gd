extends Node2D

signal item_selected(item)

@export var item_type: KnowlageShop.Types

var item: set=set_item

func set_item(new_item):
	if item:
		item.queue_free()
	add_child(new_item)
	new_item.selected.connect(on_item_selected)
	new_item.global_position = global_position
	item = new_item

func _ready():
	spawn_item()

func spawn_item():
	item = preload("res://library/item.tscn").instantiate()
	item.item_data = KnowlageShop.get_item_data(item_type)

func on_item_selected():
	item_selected.emit(item)
