extends Node2D

signal selected()

var item_data: ItemData:set=set_item_data

func set_item_data(new_data):
	item_data = new_data
	$ItemName.set_text(item_data.item_name)

func _on_area_2d_mouse_entered():
	$AnimationPlayer.play("mouse_action")


func _on_area_2d_mouse_exited():
	$AnimationPlayer.play_backwards("mouse_action")

func _on_area_2d_input_event(viewport, event:InputEvent, shape_idx):
	if event.is_action_pressed("player_select"):
		selected.emit()
