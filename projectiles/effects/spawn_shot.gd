extends Effect
class_name SpawnShotEffect

@export_category("Bullets")
@export var shot_scene: PackedScene = preload("res://projectiles/shot.tscn")
@export var damage: float = 3
@export var speed: float = 700
@export var speed_variance: float = 0
@export var pierce: int = 0
@export var lifetime_override: float = 0

func cause():
	var shot = shot_scene.instantiate()
	shot.speed = speed+randf_range(-speed_variance,speed_variance)
	shot.damage = damage
	shot.pierce = pierce
	shot.target_groups = ["enemy"]
	if lifetime_override: shot.life_time = lifetime_override
	get_tree().get_first_node_in_group("world").call_deferred("add_child",shot)
	shot.global_position = global_position
