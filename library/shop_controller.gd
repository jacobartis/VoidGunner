extends Node2D

var selected_item: set=set_selected_item

func _ready():
	KnowledgeShop.knowledge_update.connect(update_knowledge_display)
	update_knowledge_display(KnowledgeShop.knowledge)
	var spawn_locals = get_tree().get_nodes_in_group("ItemSpawn")
	for x in (randi()%(spawn_locals.size()-1))+1:
		spawn_locals.pick_random().spawn_item()

func update_knowledge_display(val):
	%knowledgeDisplay.set_text(str("knowledge : ",val))

func set_selected_item(new_item):
	if new_item == selected_item:
		return
	
	selected_item = new_item
	var cam_anim = get_tree().create_tween().set_parallel(true)
	if selected_item:
		%InventDisplay.hide()
		toggle_invent_display(false)
		%BuyButton.disabled = KnowledgeShop.knowledge<selected_item.item_data.price
		%BuyButton.show()
		cam_anim.tween_property($Camera2D, "global_position",selected_item.global_position,.5)
		cam_anim.tween_property($Camera2D, "zoom",Vector2(1.5,1.5),.5)
	else:
		%InventDisplay.show()
		%BuyButton.hide()
		cam_anim.tween_property($Camera2D, "global_position",global_position,.5)
		cam_anim.tween_property($Camera2D, "zoom",Vector2(1,1),.5)

func _input(event):
	if event.is_action_pressed("player_cancel") and selected_item:
		selected_item = null
	if event.is_action_pressed("debug_toggle_shop"):
		get_tree().change_scene_to_file("res://world.tscn")

func on_item_selected(item):
	selected_item = item

func on_buy_button_pressed():
	if !selected_item:
		push_error("Buy button pressed with no item selected")
		return
	KnowledgeShop.knowledge -= selected_item.item_data.price
	selected_item.item_data.apply_to(KnowledgeShop.player_stats)
	selected_item.queue_free()
	selected_item = null

func toggle_invent_display(toggle:bool):
	print(toggle)
	var invent_tween = get_tree().create_tween()
	if !toggle:
		invent_tween.tween_property(%InventDisplay, "global_position",Vector2(0,616),1)
		%ToggleInvent.button_pressed = false
	else:
		invent_tween.tween_property(%InventDisplay, "global_position",Vector2(0,83),1)

