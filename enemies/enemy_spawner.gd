extends Node2D

const MELEE = preload("res://enemies/enemy.tscn")
const RANGED = preload("res://enemies/shooting_enemy.tscn")

func get_enemy():
	var enemy
	match randi()%2:
		0:
			enemy = MELEE.instantiate()
		1:
			enemy = RANGED.instantiate()
	return enemy

func try_spawn(attempts:int=0):
	position = Vector2.LEFT.rotated(2*PI*randf())*randf_range(700,800)
	await get_tree().physics_frame
	if $Area2D.has_overlapping_bodies():
		if attempts<=5:
			try_spawn(attempts+1)
			return
		else:
			print("fail")
			return
	var enemy = get_enemy()
	if !enemy: return
	enemy.global_position = global_position
	get_tree().get_first_node_in_group("world").add_child(enemy)
