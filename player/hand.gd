extends Node2D

var weapon :set=set_weapon 

func set_weapon(packed_weap:PackedScene):
	if weapon:
		weapon.queue_free()
	weapon = packed_weap.instantiate()
	add_child(weapon)
	weapon.global_position = global_position

func _ready():
	weapon = preload("res://weapons/pistol.tscn")

func _process(delta):
	if get_global_mouse_position().x<=global_position.x:
		weapon.is_left.emit(true)
	else:
		weapon.is_left.emit(false)

func shoot():
	if !weapon:return
	weapon.shoot()

func reload():
	if !weapon:return
	weapon.reload()
