extends Area2D

signal player_found()

func _physics_process(delta):
		if !get_overlapping_bodies().filter(func(body): return body.is_in_group("player")).is_empty():
			player_found.emit()
