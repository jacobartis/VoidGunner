extends CharacterBody2D

signal killed(points)

@export_category("shot info")
@export var shot_packed: PackedScene = null
@export var shot_speed = 400.0
@export var shot_damage = 1
@export var attacks_per_second = 2
var remaining_cooldown: float = 0

@export_category("stats")
@export var health = 10
@export var damage = 1
@export var speed = 200.0
@export var point_value = 10.0

var dead: bool = false

func _ready():
	killed.connect(get_tree().get_first_node_in_group("score_tracker").add_score)

func _process(delta):
	if remaining_cooldown:
		remaining_cooldown -= delta

func _physics_process(delta):
	if dead: return
	var player_pos = get_tree().get_first_node_in_group("player").global_position
	if global_position.distance_to(player_pos)>= 100:
		velocity = global_position.direction_to(player_pos)*speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func hit(damage):
	health -= damage
	if health<=0:
		speed = 0
		dead = true
		killed.emit(point_value)
		$AnimationPlayer.play("death")
		await $AnimationPlayer.animation_finished
		queue_free()
		return
	global_position -= velocity.normalized()*(10+damage)
	$AnimationPlayer.play("damage")

func shoot():
	if dead: return
	if !$ProjOffset or remaining_cooldown>0: return
	var player_pos = get_tree().get_first_node_in_group("player").global_position
	$ProjOffset.look_at(player_pos)
	var shot = shot_packed.instantiate()
	shot.direction = Vector2.RIGHT.rotated($ProjOffset.global_rotation)
	shot.speed = shot_speed
	shot.damage = shot_damage
	get_tree().get_first_node_in_group("world").call_deferred("add_child",shot)
	shot.global_position = $ProjOffset/ProjSpawn.global_position
	remaining_cooldown = 1.0/attacks_per_second

func drop_item(item):
	item.global_position = global_position
	get_tree().get_first_node_in_group("world").call_deferred("add_child",item)
	
