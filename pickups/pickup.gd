extends Node

signal picked_up(body)

func _on_area_2d_body_entered(body):
	if !body.is_in_group("player"):return
	picked_up.emit(body)
	queue_free()
