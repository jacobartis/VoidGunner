extends Control

signal player_stats(val)

func _ready():
	player_stats.emit(KnowledgeShop.player_stats)

