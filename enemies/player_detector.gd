extends Area2D

signal player_found()

func _on_body_entered(body):
	if !body.is_in_group("player"):return
	player_found.emit()
