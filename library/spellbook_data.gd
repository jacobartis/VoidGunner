extends ItemData
class_name SpellbookItemData

var type:KnowledgeShop.Types = KnowledgeShop.Types.Spellbook
@export_category("Spellbook Info")
@export var spell: Spell

func get_printable_stats():
	var arr = super()
	arr.append_array(spell.get_printable_stats())
	return arr

func randomize_stats(rarity:KnowledgeShop.Rarities):
	match rarity:
		KnowledgeShop.Rarities.Common:
			item_name = "Laymans "+item_name
		KnowledgeShop.Rarities.Rare:
			item_name = "Astute "+item_name
		KnowledgeShop.Rarities.Epic:
			item_name = "Expert "+item_name
		KnowledgeShop.Rarities.Legendary:
			item_name = "Unfathomable "+item_name
	price = randi_range(price*(rarity*2+1)*.75,price*(rarity*2+1))
	spell.randomize_stats(rarity)

func apply_to(stats:PlayerStats):
	stats.add_spell(spell.duplicate())
