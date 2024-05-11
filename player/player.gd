extends CharacterBody2D

signal distance_moved(dist)

@export_category("Goop")
@export var node_gap: float = 100
@export var activation_delay: int = 3
@export var trail_length: int = 20
@export var gain_speed: float = 1

var distance = 0
var goop_value = 0: set=set_goop_value
var overlaping_goop: Array = []

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func set_goop_value(val):
	goop_value = val
	print(val)

func _process(delta):
	if overlaping_goop:
		goop_value+=delta*gain_speed

func _physics_process(delta):
	$HandOffset.look_at(get_global_mouse_position())
	var direction = Input.get_vector("player_left","player_right","player_up","player_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
	if velocity:
		distance_moved.emit(velocity.length()*delta)
		distance += velocity.length()*delta
		check_spawn()

func _input(event):
	if event.is_action("player_shoot"):
		$HandOffset/Hand.shoot()

func hit(damage):
	print("ow ",damage)

func check_spawn():
	if distance>=node_gap:
		var goop = preload("res://goop/goop.tscn").instantiate()
		goop.global_position = global_position
		goop.required_dist = node_gap*activation_delay
		goop.despawn_dist = node_gap*trail_length
		get_parent().add_child(goop)
		distance_moved.connect(goop.add_distance)
		distance = 0
