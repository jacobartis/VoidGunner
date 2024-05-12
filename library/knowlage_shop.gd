extends Node

var knowlage: int = 0
var player

func add_knowlage(val):
	knowlage += val
	print(knowlage)

func set_player(val):
	player = val

func get_spells():
	if !player: return
	return player.get_spell_manager().get_spells()
