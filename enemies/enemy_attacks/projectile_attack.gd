extends EnemyAttack
class_name ProjectileAttack

@export_category("Attack Data")
@export var shot_scene: PackedScene
@export var fire_rate: float = 2
@export var shots_per_attack: int = 1
@export var delay_between_shots: float = 0
@export var speed: float = 700
@export var speed_variance: float = 0
@export var pierce: int = 0
@export var max_angle: float = 0
@export var lifetime_override: float = 0
@export var speed_variation_override: CurveTexture

var remaining_cooldown: float = 0

func _process(delta):
	if remaining_cooldown:
		remaining_cooldown -= delta

func attack(args:Dictionary):
	if remaining_cooldown>0: return
	remaining_cooldown = 1.0/fire_rate
	for x in shots_per_attack:
		var shot = shot_scene.instantiate()
		shot.direction = args["AttackDirection"].rotated(deg_to_rad(randf_range(-max_angle,max_angle)))
		shot.speed = speed+randf_range(-speed_variance,speed_variance)
		shot.damage = args["Damage"]
		if lifetime_override: shot.life_time = lifetime_override
		if speed_variation_override: shot.speed_variation = speed_variation_override
		get_tree().get_first_node_in_group("world").call_deferred("add_child",shot)
		shot.global_position = global_position
		await get_tree().create_timer(delay_between_shots).timeout
		attacking.emit()
