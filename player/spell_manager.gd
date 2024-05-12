extends Node2D

signal new_spell_selected(spell)

@export var player: CharacterBody2D
@export var spell_slots: int = 2
@onready var spells = []
var current_spell: int = 0

func add_spell(spell):
	if spells.size()>=spell_slots:
		spells.pop_front()
	spells.append(spell)

func _ready():
	var spell
	for x in range(2):
		print(x)
		if x == 0:
			spell = preload("res://spells/scenes/minigun_spell.tscn").instantiate()
		elif x == 1: 
			spell = preload("res://spells/scenes/screen_clear.tscn").instantiate()
		add_spell(spell)
	new_spell_selected.emit(spells[current_spell])
	print(spells)

func _process(delta):
	for spell in spells:
		spell.process(delta)

func _input(event):
	if event.is_action_pressed("player_next_spell"):
		current_spell = (current_spell+1)%spells.size()
		new_spell_selected.emit(spells[current_spell])
	elif event.is_action_pressed("player_prev_spell"):
		current_spell = (current_spell-1)%spells.size()
		new_spell_selected.emit(spells[current_spell])

func cast_current():
	var spell = spells[current_spell]
	if player.madness<spell.cost or !spell.can_cast():return
	player.madness -= spell.cost
	spell.cast(player)
