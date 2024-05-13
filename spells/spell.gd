extends Resource
class_name Spell

@export_category("Spell Basics")
@export var name: String = "PlaceholderSpell"
@export var cost: float = 10.0
@export var cooldown: float = 5.0

var remaining: float = 0

func randomize_stats(rarity:KnowledgeShop.Rarities):
	var dist = KnowledgeShop.get_rarity_dist(rarity,3)
	match rarity:
		KnowledgeShop.Rarities.Common:
			name = "Lesser "+name
		KnowledgeShop.Rarities.Epic:
			name = "Greater "+name
		KnowledgeShop.Rarities.Legendary:
			name = "Supreme "+name
	update_power(dist[0])
	cost = clamp(cost/dist[1],0,95)
	cooldown = clamp(cooldown/dist[2],2.5,120)

func update_power(mult):
	pass

func can_cast():
	return remaining<=0

func process(delta):
	if remaining>0:
		remaining -= delta
	else:
		remaining = 0

func cast(body):
	remaining = cooldown
