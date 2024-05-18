extends Control

signal player_stats(val)

func _ready():
	update_stats()

func update_stats():
	player_stats.emit(GameManager.player_stats)
