extends Node2D

signal item_selected(item)

var selected_item: set=set_selected_item

func _ready():
	GameManager.knowledge_update.connect(update_knowledge_display)
	update_knowledge_display(GameManager.knowledge)
	var spawn_locals = get_tree().get_nodes_in_group("ItemSpawn")
	for x in (randi()%(spawn_locals.size()-1))+1:
		spawn_locals.pick_random().spawn_item()

func update_knowledge_display(val):
	%KnowledgeDisplay.set_text(str("knowledge : ",val))

func set_selected_item(new_item):
	if new_item == selected_item:
		return
	item_selected.emit(new_item)
	selected_item = new_item
	var menu_anim = get_tree().create_tween().set_parallel(true)
	%WeaponStats.hide()
	%SpellStats.hide()
	%PlayerStats.hide()
	if selected_item:
		%InventDisplay.hide()
		toggle_invent_display(false)
		%BuyButton.show()
		%BuyButton.disabled = GameManager.knowledge<selected_item.item_data.price
		%QuitButton.hide()
		
		menu_anim.tween_property($Camera2D, "global_position",selected_item.global_position,.5)
		menu_anim.tween_property($Camera2D, "zoom",Vector2(1.5,1.5),.5)
		menu_anim.tween_property(%StatsDisplay,"position",Vector2(1260,123),.5)
		menu_anim.tween_property(%ItemDisplay,"position",Vector2(0,123),.5)
	else:
		%InventDisplay.show()
		%BuyButton.hide()
		%QuitButton.show()
		menu_anim.tween_property($Camera2D, "global_position",global_position,.5)
		menu_anim.tween_property($Camera2D, "zoom",Vector2(1,1),.5)
		menu_anim.tween_property(%StatsDisplay,"position",Vector2(2000,123),.5)
		menu_anim.tween_property(%ItemDisplay,"position",Vector2(-1000,123),.5)
		return
	if selected_item.item_data is WeaponItemData:
		%WeaponStats.show()
	elif selected_item.item_data is SpellbookItemData:
		%SpellStats.show()
	elif selected_item.item_data is ElixerItemData:
		%PlayerStats.show()

func _input(event):
	if event.is_action_pressed("player_cancel") and selected_item:
		selected_item = null

func on_item_selected(item):
	selected_item = item

func on_buy_button_pressed():
	if !selected_item:
		push_error("Buy button pressed with no item selected")
		return
	GameManager.knowledge -= selected_item.item_data.price
	selected_item.item_data.apply_to(GameManager.player_stats)
	selected_item.queue_free()
	selected_item = null

func on_quit_button_pressed():
	%InventDisplay.show()
	%QuitButton.hide()
	%AnimationPlayer.play("exit")
	await %AnimationPlayer.animation_finished
	GameManager.to_level()

func toggle_invent_display(toggle:bool):
	var invent_tween = get_tree().create_tween()
	if !toggle:
		invent_tween.tween_property(%InventDisplay, "global_position",Vector2(0,1029),1)
		%ToggleInvent.button_pressed = false
	else:
		invent_tween.tween_property(%InventDisplay, "global_position",Vector2(0,140),1)

