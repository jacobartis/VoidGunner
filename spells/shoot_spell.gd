extends Spell
class_name ShootSpell

@export_category("Shoot Stats")
@export var quantity: int = 1
@export var max_angle: float = 0
@export var delay_between: float = 0

@export_category("Shot Stats")
@export var shot_packed: PackedScene = null
@export var shot_speed = 400.0
@export var shot_damage = 1

func get_printable_stats():
	var arr = super()
	arr.append_array([str("Shots: ",snapped(quantity,0.1)),
	str("Spread: ",snapped(max_angle,0.1),"deg"),
	str("Fire Rate: ",snapped(1.0/delay_between,0.1)),
	str("Damage: ",snapped(shot_damage,0.1)),
	str("Shot Speed: ",snapped(shot_speed,0.1))])
	return arr

func update_power(mult):
	shot_damage = shot_damage*sqrt(mult)

func cast(body):
	for x in quantity:
		var shot = shot_packed.instantiate()
		shot.damage = shot_damage
		shot.speed = shot_speed
		shot.direction = body.global_position.direction_to(body.get_global_mouse_position()).rotated(deg_to_rad(randf_range(-max_angle,max_angle)))
		shot.target_groups = ["enemy"]
		body.get_tree().get_first_node_in_group("world").add_child(shot)
		shot.global_position = body.global_position
		await body.get_tree().create_timer(delay_between).timeout
	remaining = cooldown
