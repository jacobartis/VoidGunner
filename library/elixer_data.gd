extends ItemData
class_name ElixerItemData

var type:KnowledgeShop.Types = KnowledgeShop.Types.Elixer
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
@export var knowledge_mult: float = 0
@export var gain_speed: float = 0

func total_changes():
	var total = 0
	total += 1 if max_health else 0
	total += 1 if speed else 0
	total += 1 if dash_cooldown else 0
	total += 1 if dash_speed else 0
	total += 1 if dash_distance else 0
	total += 1 if node_gap else 0
	total += 1 if activation_delay else 0
	total += 1 if trail_length else 0
	total += 1 if knowledge_mult else 0
	total += 1 if gain_speed else 0
	return total

func randomize_stats(rarity:KnowledgeShop.Rarities):
	match rarity:
		KnowledgeShop.Rarities.Common:
			item_name = "Diluted "+item_name
		KnowledgeShop.Rarities.Rare:
			item_name = "Standard "+item_name
		KnowledgeShop.Rarities.Epic:
			item_name = "Pure "+item_name
		KnowledgeShop.Rarities.Legendary:
			item_name = "Potent "+item_name
	price = randi_range(price*(rarity*2+1)*.75,price*(rarity*2+1))
	var dist = KnowledgeShop.get_rarity_dist(rarity,total_changes())
	#Horrid, do not look
	var current = 0
	if max_health:
		max_health = clamp(max_health*dist[current],-50,50) 
		current += 1
	if speed:
		speed = clamp(speed*dist[current],-500,500) 
		current += 1
	if dash_cooldown:
		dash_cooldown = clamp(dash_cooldown*dist[current],-20,20) 
		current += 1
	if dash_speed:
		dash_speed = clamp(dash_speed*dist[current],-500,500) 
		current += 1
	if dash_distance:
		dash_distance = clamp(dash_distance*dist[current],-500,500) 
		current += 1
	if node_gap:
		node_gap = clamp(node_gap*dist[current],-500,500) 
		current += 1
	if activation_delay:
		activation_delay = clamp(activation_delay*dist[current],-10,10) 
		current += 1
	if trail_length:
		trail_length = clamp(trail_length*dist[current],-20,20) 
		current += 1
	if knowledge_mult:
		knowledge_mult = clamp(knowledge_mult*dist[current],-2,2) 
		current += 1
	if gain_speed:
		gain_speed = clamp(gain_speed*dist[current],-10,10) 
		current += 1

func apply_to(stats:PlayerStats):
	stats.max_health += max_health
	stats.speed += speed
	stats.dash_cooldown += dash_cooldown
	stats.dash_speed += dash_speed
	stats.dash_distance += dash_distance
	stats.node_gap += node_gap
	stats.activation_delay += activation_delay
	stats.trail_length += trail_length
	stats.knowledge_mult += knowledge_mult
	stats.gain_speed += gain_speed
