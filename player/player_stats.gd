extends Resource
class_name PlayerStats

@export_category("Stats")
@export var can_take_damage: bool = true
@export var max_health: float = 10
@export var speed: float = 400.0

@export_category("Goop")
@export var node_gap: float = 100
@export var activation_delay: int = 3
@export var trail_length: int = 20
@export var knowlage_mult: float = 2
@export var gain_speed: float = 1

@export_category("Dash")
@export var dashing_enabled: bool = true
@export var dash_cooldown: float = 20
@export var dash_speed: float = 500
@export var dash_distance: float = 200

@export_category("Spells")
@export var spell_slots: int = 2
@export var spells: Array = []

@export_category("Weapon")
@export var weapon: PackedScene

func save_stats(player):
	can_take_damage = player.can_take_damage
	max_health = player.max_health
	speed = player.speed
	node_gap = player.node_gap
	activation_delay = player.activation_delay
	trail_length = player.trail_length
	knowlage_mult = player.knowlage_mult
	gain_speed = player.gain_speed
	dashing_enabled = player.dashing_enabled
	dash_cooldown = player.dash_cooldown
	dash_speed = player.dash_speed
	dash_distance = player.dash_distance
	spell_slots = player.get_spell_manager().spell_slots
	spells = player.get_spell_manager().spells
	weapon = PackedScene.new()
	weapon.pack(player.get_hand().weapon)

func load_stats(player):
	player.can_take_damage = can_take_damage
	player.max_health = max_health
	player.speed = speed
	player.node_gap = node_gap
	player.activation_delay = activation_delay
	player.trail_length = trail_length
	player.knowlage_mult = knowlage_mult
	player.gain_speed = gain_speed
	player.dashing_enabled = dashing_enabled
	player.dash_cooldown = dash_cooldown
	player.dash_speed = dash_speed
	player.dash_distance = dash_distance
	player.get_spell_manager().spell_slots = spell_slots
	player.get_spell_manager().spells = spells
	player.get_hand().set_weapon(weapon)

func add_spell(spell):
	if spells.size()>=spell_slots:
		spells.pop_front()
	spells.append(spell)
