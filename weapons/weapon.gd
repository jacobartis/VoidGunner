extends Node2D

signal is_left(val)

@export_category("Weapon")
## Fire rate in bullets per second.
@export var fire_rate: float = 2
@export var shots_per_attack: int = 1
@export var max_angle: float = 0
@export var cartrage: bool = true
@export var auto_reload:bool = false
@export_category("Ammo")
@export var max_ammo: int = 6
@export var reload_time: float = 1
@onready var ammo = max_ammo
var reloading: bool = false
@export_category("Bullets")
@export var shot_scene: PackedScene = preload("res://projectiles/shot.tscn")
@export var damage: float = 3
@export var speed: float = 700
@export var speed_variance: float = 0
@export var pierce: int = 0
@export var lifetime_override: float = 0
@export var speed_variation_override: CurveTexture

var madness_mult: float = 0: set=set_madness_mult
var can_shoot: bool = true

func set_madness_mult(val):
	madness_mult = val
	$Sprites/Weapon.get_material().set_shader_parameter("intencity",madness_mult)

func get_printable_stats():
	return [str("Damage: ",snapped(damage,.1)),
	str("Fire Rate: ",snapped(fire_rate,.1)),
	str("Ammo: ",snapped(max_ammo,.1)),
	str("Shots Per Attacks: ",snapped(shots_per_attack,.1)),
	str("Spread: ",snapped(max_angle,.1)),
	str("Reload Duration: ",snapped(reload_time,.1)),
	str("Shot Speed: ",snapped(speed,.1)),
	str("Pierce: ",snapped(pierce,.1))]

func randomize_stats(rarity:KnowledgeShop.Rarities):
	var dist = KnowledgeShop.get_rarity_dist(rarity,7)
	fire_rate = clamp(fire_rate*sqrt(dist[0]),0,INF)
	damage = clamp(damage*sqrt(dist[0]),0,INF)
	reload_time = clamp(reload_time/sqrt(dist[0]),0,INF)
	shots_per_attack = shots_per_attack+round(shots_per_attack/5*dist[3])
	max_ammo = max_ammo+round(max_ammo/5*dist[4]*2)
	pierce = pierce+snapped(dist[5]/2,1)

func shoot():
	if !can_shoot: return
	if ammo<=0:
		reload()
		return
	
	for x in shots_per_attack:
		var shot = shot_scene.instantiate()
		shot.direction = Vector2.RIGHT.rotated(global_rotation).rotated(deg_to_rad(randf_range(-max_angle,max_angle)))
		shot.speed = speed+randf_range(-speed_variance,speed_variance)
		shot.damage = damage*madness_mult
		shot.pierce = pierce
		shot.target_groups = ["enemy"]
		if lifetime_override: shot.life_time = lifetime_override
		if speed_variation_override: shot.speed_variation = speed_variation_override
		get_tree().get_first_node_in_group("world").add_child(shot)
		shot.global_position = $ProjSpawn.global_position
		$AnimationPlayer.stop()
		$AnimationPlayer.play("shoot")
	ammo -= 1
	can_shoot = false
	await get_tree().create_timer(1.0/fire_rate).timeout
	can_shoot = true
	
	if ammo<=0 and auto_reload:
		reload()
		return

func reload():
	if reloading or max_ammo==ammo: return
	reloading = true
	can_shoot = false
	$Reload.play()
	if cartrage:
		await get_tree().create_timer(reload_time).timeout
	else:
		await get_tree().create_timer((reload_time/max_ammo)*(max_ammo-ammo)).timeout
	$Reload.stop()
	$ReloadEnd.play()
	ammo = max_ammo
	can_shoot = true
	reloading = false
