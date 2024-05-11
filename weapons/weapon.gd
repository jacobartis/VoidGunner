extends Node2D

signal is_left(val)

@export_category("Weapon")
## Fire rate in bullets per second.
@export var fire_rate: float = 2
@export_category("Ammo")
@export var max_ammo: int = 6
@export var reload_time: float = 1
var ammo = max_ammo
var reloading: bool = false
@export_category("Bullets")
@export var damage: float = 3
@export var speed: float = 700

var can_shoot: bool = true

func shoot():
	if !can_shoot: return
	if ammo<=0:
		reload()
		return
	
	var shot = preload("res://projectiles/shot.tscn").instantiate()
	shot.direction = Vector2.RIGHT.rotated(global_rotation)
	shot.speed = speed
	shot.damage = damage
	shot.target_groups = ["enemy"]
	get_tree().get_first_node_in_group("world").add_child(shot)
	shot.global_position = $ProjSpawn.global_position
	$AnimationPlayer.stop()
	$AnimationPlayer.play("shoot")
	ammo -= 1
	can_shoot = false
	await get_tree().create_timer(1.0/fire_rate).timeout
	can_shoot = true

func reload():
	if reloading: return
	reloading = true
	can_shoot = false
	$Reload.play()
	await get_tree().create_timer(reload_time).timeout
	$Reload.stop()
	$ReloadEnd.play()
	ammo = max_ammo
	can_shoot = true
	reloading = false
