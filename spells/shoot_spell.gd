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
