extends CharacterBody2D

signal distance_moved(dist)
signal health_update(value)
signal max_health_update(value)
signal madness_update(value)

@export_category("Madness")
@export var node_gap: float = 100
@export var activation_delay: int = 3
@export var trail_length: int = 20
@export var knowledge_mult: float = 2:set=set_knowledge_mult
@export var gain_speed: float = 1

var distance = 0
var madness = 0: set=set_madness_value
var overlaping_goop: Array = []
var time_out_goop: float

@export_category("Dash")
@export var dashing_enabled: bool = true
@export var dash_cooldown: float = 20
@export var dash_speed: float = 500
@export var dash_distance: float = 200

var can_dash: bool = dashing_enabled: set=set_can_dash
var dash_dist_remaining: float
var dash_dir: Vector2

@export_category("Stats")
@export var can_take_damage: bool = true
@export var max_health: float = 10: set=set_max_health
@export var speed: float = 400.0
@onready var health: float = max_health: set=set_health
var dead: bool = false

func set_knowledge_mult(val):
	knowledge_mult = val

func set_madness_value(val):
	madness = val
	health = health
	call_deferred("emit_signal","madness_update",madness)

func set_max_health(val):
	max_health = val
	max_health_update.emit(max_health)

func set_health(val):
	health = clamp(val,0,max_health-(max_health/100.0)*madness)
	max_health_update.emit(max_health-(max_health/100.0)*madness)
	health_update.emit(health)

func set_can_dash(val):
	can_dash = val and dashing_enabled

func add_knowledge(val):
	GameManager.add_knowledge(val*round(1+knowledge_mult*madness/100))

func get_spell_manager():
	return $SpellManager

func get_hand():
	return %Hand

func _ready():
	$CanvasLayer.show()
	GameManager.open_shop.connect(shop_transition)
	if GameManager.player_stats:
		GameManager.player_stats.load_stats(self)
	save_stats()
	max_health = max_health
	health = health
	madness = madness

func _process(delta):
	if dead: return
	if overlaping_goop:
		madness+=delta*gain_speed
		time_out_goop = 0
	else:
		time_out_goop += delta
	if time_out_goop>=5:
		madness = clamp(madness-(gain_speed*delta)/5,0,100)
	if Input.is_action_pressed("player_shoot"):
		%Hand.shoot()

func _physics_process(delta):
	if dead: return
	$HandOffset.look_at(get_global_mouse_position())
	var direction = Input.get_vector("player_left","player_right","player_up","player_down")
	if Input.is_action_just_pressed("player_dash") and can_dash:
		enter_dash(direction)
	
	if dash_dist_remaining:
		$AnimationPlayer.play("dash")
		velocity = dash_dir * dash_speed
	elif direction:
		$AnimationPlayer.play("walk")
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	
	var collision = move_and_slide()
	if velocity:
		distance_moved.emit(velocity.length()*delta)
		distance += velocity.length()*delta
		check_spawn()
	if dash_dist_remaining:
		dash_dist_remaining -= velocity.length()*delta
		if dash_dist_remaining<=0 or collision:
			dash_dist_remaining = 0
			exit_dash()

func _input(event):
	if dead: return
	if event.is_action_pressed("player_reload"):
		%Hand.reload()
	if event.is_action_pressed("player_cast"):
		$SpellManager.cast_current()

func shop_transition():
	save_stats()
	$CanvasLayer.hide()

func save_stats():
	var stats = PlayerStats.new()
	stats.save_stats(self)
	GameManager.player_stats = stats

func enter_dash(dir):
	dash_dir = dir
	dash_dist_remaining = dash_distance
	can_dash = false
	collision_layer = 2
	%DashCooldown.start(dash_cooldown)
	await %DashCooldown.timeout
	can_dash = true

func exit_dash():
	collision_layer = 3

func hit(damage):
	if !can_take_damage: return
	print("ow ",damage)
	health -= damage
	if health<=0:
		dead = true
		$AltAnimationPlayer.play("death")
		await $AltAnimationPlayer.animation_finished
		GameManager.end_game()
		return
	can_take_damage = false
	$AltAnimationPlayer.play("damaged")
	await $AltAnimationPlayer.animation_finished
	can_take_damage = true

func check_spawn():
	if distance>=node_gap:
		var goop = preload("res://goop/goop.tscn").instantiate()
		goop.global_position = global_position
		goop.required_dist = node_gap*activation_delay
		goop.despawn_dist = node_gap*trail_length
		get_tree().get_first_node_in_group("goop_home").add_child(goop)
		distance_moved.connect(goop.add_distance)
		distance = 0

func on_entering_shop():
	GameManager.set_player(self)
