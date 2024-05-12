extends Node2D

var selected_item: set=set_selected_item

func set_selected_item(new_item):
	if new_item == selected_item:
		%BuyButton.hide()
		return
	
	selected_item = new_item
	var cam_anim = get_tree().create_tween().set_parallel(true)
	if selected_item:
		cam_anim.tween_property($Camera2D, "global_position",selected_item.global_position,.5)
		cam_anim.tween_property($Camera2D, "zoom",Vector2(1.5,1.5),.5)
	else:
		cam_anim.tween_property($Camera2D, "global_position",global_position,.5)
		cam_anim.tween_property($Camera2D, "zoom",Vector2(1,1),.5)
	%BuyButton.show()

func _input(event):
	if event.is_action_pressed("player_cancel") and selected_item:
		selected_item = null
	if event.is_action_pressed("debug_toggle_shop"):
		get_tree().change_scene_to_file("res://world.tscn")

func on_item_selected(item):
	selected_item = item
	print(selected_item.item_data)

func on_buy_button_pressed():
	if !selected_item:
		push_error("Buy button pressed with no item selected")
		return
	selected_item.item_data.apply_to(KnowlageShop.player_stats)
