extends CharacterBody2D

signal killed(points)
signal attack(args)
signal max_health_update(val)
signal health_update(val)

@export_category("stats")
@export var price: int = 1
@export var min_wave: int = 1
@export var max_health: float = 10:set=set_max_health
@export var damage = 1
@export var speed = 200.0
@export var knowledge_value = 10.0

@onready var health: float = max_health:set=set_health
var dash_dist: float

var dead: bool = false

var wave_mult: float = .1

func set_health(val):
	health = clamp(val,0,max_health)
	health_update.emit(health)

func set_max_health(val):
	max_health = val
	max_health_update.emit(max_health)

func sale_stats(wave_value):
	damage += floori(damage*wave_mult*wave_value)
	health += floori(health*wave_mult*wave_value)
	knowledge_value += floori(knowledge_value*wave_mult*wave_value)

func _ready():
	sale_stats(GameManager.wave)
	GameManager.alive_enemies += 1
	tree_exited.connect(GameManager.enemy_killed)
	health_update.emit(health)
	max_health_update.emit(max_health)
	killed.connect(get_tree().get_first_node_in_group("player").add_knowledge)

func _process(delta):
	for body in $ContactDamage.get_overlapping_bodies().filter(func(body):return body.is_in_group("player")):
		body.hit(damage)

func _physics_process(delta):
	if dead: return
	var player_pos = get_tree().get_first_node_in_group("player").global_position
	if dash_dist:
		pass
	elif global_position.distance_to(player_pos)>= 100:
		velocity = global_position.direction_to(player_pos)*speed
	else:
		velocity = Vector2.ZERO
	var collision = move_and_slide()
	if dash_dist:
		dash_dist -= velocity.length()*delta
		if dash_dist<=0 or collision:
			dash_dist = 0
			collision_layer = 1

func hit(damage):
	health -= damage
	if health<=0 and !dead:
		speed = 0
		dead = true
		$AnimationPlayer.play("death")
		await $AnimationPlayer.animation_finished
		killed.emit(knowledge_value)
		var drop_chance = randi()%100
		if drop_chance <= 15:
			drop_item(preload("res://pickups/scenes/knowldedge_pickup.tscn"))
		elif drop_chance <= 20:
			drop_item(preload("res://pickups/scenes/health_pickup.tscn"))
		queue_free()
		return
	global_position -= velocity.normalized()*(10+damage)
	$AnimationPlayer.play("damage")

func shoot():
	if dead: return
	if !$ProjOffset: return
	var player_pos = get_tree().get_first_node_in_group("player").global_position
	$ProjOffset.look_at(player_pos)
	var args: Dictionary = {}
	args["Body"] = self
	args["AttackDirection"] = Vector2.RIGHT.rotated($ProjOffset.global_rotation)
	args["Damage"] = damage
	attack.emit(args)

func enter_dash(dir, dist, speed):
	dash_dist = dist
	collision_layer = 4
	velocity = dir*speed

func drop_item(item:PackedScene):
	var inst = item.instantiate()
	inst.global_position = global_position
	get_tree().get_first_node_in_group("world").call_deferred("add_child",inst)
