extends ItemData
class_name ElixerItemData

var type:KnowledgeShop.Types = KnowledgeShop.Types.Elixer
@export_category("Stat Changes")
@export var max_health: float = 0
@export var speed: float = 0.0
@export var spell_slots: int = 0

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
	total += 1 if spell_slots else 0
	total += 1 if dash_cooldown else 0
	total += 1 if dash_speed else 0
	total += 1 if dash_distance else 0
	total += 1 if node_gap else 0
	total += 1 if activation_delay else 0
	total += 1 if trail_length else 0
	total += 1 if knowledge_mult else 0
	total += 1 if gain_speed else 0
	return total

func get_printable_stats():
	var arr = super()
	if max_health: arr.append(str("Max Health: ",snapped(max_health,.1)))
	if speed: arr.append(str("Speed: ",snapped(speed,.1)))
	if spell_slots:arr.append(str("Spell slots: ",snapped(spell_slots,.1)))
	if dash_cooldown:arr.append(str("Dash Cooldown: ",snapped(dash_cooldown,.1)))
	if dash_speed:arr.append(str("Dash Speed: ",snapped(dash_speed,.1)))
	if dash_distance:arr.append(str("Dash Distance: ",snapped(dash_distance,.1)))
	if node_gap:arr.append(str("Void Gap: ",snapped(node_gap,.1)))
	if activation_delay:arr.append(str("Void Activation Delay: ",snapped(activation_delay,.1)))
	if trail_length:arr.append(str("Void Trail Length: ",snapped(trail_length,.1)))
	if knowledge_mult:arr.append(str("Madness knowledge multi: ",snapped(knowledge_mult,.1)))
	if gain_speed:arr.append(str("Madness Gain Speed: ",snapped(gain_speed,.1)))
	return arr

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
	price = randi_range(price*(rarity*3+1)*.75,price*(rarity*3+1))
	var dist = KnowledgeShop.get_rarity_dist(rarity,total_changes())
	#Horrid, do not look
	var current = 0
	if max_health:
		max_health = max_health*sqrt(dist[current])
		current += 1
	if speed:
		speed = speed*sqrt(dist[current])
		current += 1
	if spell_slots:
		spell_slots = spell_slots+floor(sqrt(dist[current])/2)
		current += 1
	if dash_cooldown:
		dash_cooldown = dash_cooldown*sqrt(dist[current])
		current += 1
	if dash_speed:
		dash_speed = dash_speed*sqrt(dist[current])
		current += 1
	if dash_distance:
		dash_distance = dash_distance*sqrt(dist[current])
		current += 1
	if node_gap:
		node_gap = node_gap*sqrt(dist[current])
		current += 1
	if activation_delay:
		activation_delay = activation_delay*sqrt(dist[current])
		current += 1
	if trail_length:
		trail_length = trail_length*sqrt(dist[current])
		current += 1
	if knowledge_mult:
		knowledge_mult = knowledge_mult*sqrt(dist[current])
		current += 1
	if gain_speed:
		gain_speed = gain_speed*sqrt(dist[current])
		current += 1

func apply_to(stats:PlayerStats):
	stats.max_health += max_health
	stats.speed += speed
	stats.spell_slots += spell_slots
	stats.dash_cooldown += dash_cooldown
	stats.dash_speed += dash_speed
	stats.dash_distance += dash_distance
	stats.node_gap += node_gap
	stats.activation_delay += activation_delay
	stats.trail_length += trail_length
	stats.knowledge_mult += knowledge_mult
	stats.gain_speed += gain_speed
