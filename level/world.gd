extends Node2D

signal enemy_qunat_update(val)

const ENEMIES = [preload("res://enemies/enemy_scenes/eye.tscn"),
	preload("res://enemies/enemy_scenes/skull.tscn"),
	preload("res://enemies/enemy_scenes/bow_imp.tscn"),
	preload("res://enemies/enemy_scenes/imp.tscn"),
	preload("res://enemies/enemy_scenes/imp_fighter.tscn"),
	preload("res://enemies/enemy_scenes/wing_imp.tscn"),
	]

@export var dist_from_player: float = 700
@export var value_per_wave: float = 1.1

func get_enemy(cost):
	return ENEMIES.filter(func(packed): return packed.instantiate().min_wave<=GameManager.wave and packed.instantiate().price<=cost).pick_random().instantiate()

func _ready():
	GameManager.playing_rounds = true
	GameManager.new_wave.connect(spawn_wave)
	GameManager.open_shop.connect(shop_transition)
	GameManager.game_end.connect(%AnimationPlayer.stop)
	get_tree().get_first_node_in_group("player").global_position = get_tree().get_nodes_in_group("spawn").pick_random().global_position

func shop_transition():
	%AnimationPlayer.play("shop_transition")
	await %AnimationPlayer.animation_finished
	GameManager.go_to_shop()

func spawn_wave(wave):
	var to_spawn = max(ceil(2*wave),ceil(pow(value_per_wave,wave)))
	print("to spawn ",to_spawn)
	while to_spawn>0:
		var enemy = get_enemy(to_spawn)
		to_spawn -= enemy.price
		try_spawn(enemy)

func try_spawn(enemy):
	if !get_tree():return
	var map = get_tree().get_first_node_in_group("tilemap")
	var player = get_tree().get_first_node_in_group("player")
	var pos = map.map_to_local(map.get_used_cells(0).filter(func(cell):return map.map_to_local(cell).distance_to(player.global_position)>=dist_from_player and map.map_to_local(cell).distance_to(player.global_position)<=1000 ).pick_random())
	if !enemy: return
	enemy.global_position = pos
	get_tree().get_first_node_in_group("world").add_child(enemy)
