extends Node2D

var can_shoot: bool = true

func shoot():
	if !can_shoot: return
	var shot = preload("res://projectiles/shot.tscn").instantiate()
	shot.direction = Vector2.RIGHT.rotated(global_rotation)
	shot.speed = 5
	shot.damage = 3
	get_tree().get_first_node_in_group("world").add_child(shot)
	shot.global_position = $ProjSpawn.global_position
	$AnimationPlayer.play("shoot")
	can_shoot = false
	await $AnimationPlayer.animation_finished
	can_shoot = true
