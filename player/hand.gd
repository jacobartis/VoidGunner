extends Node2D

var weapon
var weapon_item:WeaponItemData

func set_weapon(new_weapon_item:WeaponItemData):
	if weapon:
		weapon.queue_free()
	weapon_item = new_weapon_item
	weapon = weapon_item.weapon_scene.instantiate()
	add_child(weapon)
	weapon.global_position = global_position

func _ready():
	set_weapon(preload("res://library/items/pistol.tres").duplicate(true))

func _process(delta):
	if get_global_mouse_position().x<=global_position.x:
		weapon.is_left.emit(true)
	else:
		weapon.is_left.emit(false)

func madness_modifier(val):
	weapon.madness_mult = snapped(1+GameManager.player_stats.knowledge_mult*val/100,.5)

func shoot():
	if !weapon:return
	weapon.shoot()

func reload():
	if !weapon:return
	weapon.reload()
