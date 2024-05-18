extends Node

signal new_wave(val)
signal enemy_update(val)
signal knowledge_update(val)
signal round_timer_update(val)
signal open_shop()
signal round_start()
signal round_end()
signal game_end()

var player_stats: PlayerStats

var wave: int = 0 :set=set_wave
var knowledge: int = 0: set=set_knowledge
var alive_enemies: int = 0: set=set_alive_enemies
var wave_time: float = 0: set=set_round_timer
var next_shop: int = 5
var shop_interval: int = 5
var playing_rounds: bool = false
var active_round: bool = false
#Stats
var kills: int = 0
var total_knowledge: int = 0

var music_volume: float = 0
var sound_volume:float = 0

func set_wave(val):
	wave = val

func set_knowledge(val):
	knowledge = val
	knowledge_update.emit(knowledge)

func set_alive_enemies(val):
	alive_enemies = val
	enemy_update.emit(val)

func set_round_timer(val):
	wave_time = val
	round_timer_update.emit(val)

func add_knowledge(val):
	knowledge += val
	total_knowledge += val


func _process(delta):
	wave_time = clamp(wave_time-delta,0,INF)
	if wave_time==0 and playing_rounds and active_round:
		end_round()

func end_game():
	game_end.emit()
	playing_rounds = false

func start_round():
	active_round = true
	round_start.emit()
	wave += 1
	wave_time = 20
	new_wave.emit(wave)

func end_round():
	active_round = false
	round_end.emit()
	if !playing_rounds:return
	await get_tree().create_timer(2).timeout
	if wave>=next_shop:
		open_shop.emit()
		playing_rounds = false
		next_shop += shop_interval
		shop_interval+=2
	else:
		start_round()

func enemy_killed():
	alive_enemies -= 1
	kills += 1
	if alive_enemies == 0:
		end_round()

func reset():
	player_stats = null
	wave = 0
	kills = 0
	knowledge = 0
	total_knowledge = 0
	next_shop = shop_interval

func go_to_shop():
	get_tree().call_deferred("change_scene_to_file","res://library/library_shop.tscn")

func to_level():
	get_tree().change_scene_to_file("res://level/world.tscn")
	await get_tree().create_timer(1).timeout
	start_round()
