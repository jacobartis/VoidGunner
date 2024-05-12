extends ItemData
class_name ElixerItemData

@export_category("Stat Changes")
@export var max_health: float = 0
@export var speed: float = 0.0

@export_category("Dash Changes")
@export var dash_cooldown: float = 0
@export var dash_speed: float = 0
@export var dash_distance: float = 0

@export_category("Madness Changes")
@export var node_gap: float = 0
@export var activation_delay: int = 0
@export var trail_length: int = 0
@export var knowlage_mult: float = 0
@export var gain_speed: float = 0

func apply_to(stats:PlayerStats):
	stats.max_health += max_health
	stats.speed += speed
	stats.dash_cooldown += dash_cooldown
	stats.dash_speed += dash_speed
	stats.dash_distance += dash_distance
	stats.node_gap += node_gap
	stats.activation_delay += activation_delay
	stats.trail_length += trail_length
	stats.knowlage_mult += knowlage_mult
	stats.gain_speed += gain_speed
