extends ItemData
class_name SpellbookItemData

var type:KnowlageShop.Types = KnowlageShop.Types.Spellbook
@export_category("Spellbook Info")
@export var spell: Spell

func randomize_stats(rarity:KnowlageShop.Rarities):
	match rarity:
		KnowlageShop.Rarities.Common:
			item_name = "Laymans "+item_name
		KnowlageShop.Rarities.Rare:
			item_name = "Astute "+item_name
		KnowlageShop.Rarities.Epic:
			item_name = "Expert "+item_name
		KnowlageShop.Rarities.Legendary:
			item_name = "Unfathomable "+item_name
	price = randi_range(price*(rarity*2+1)*.75,price*(rarity*2+1))
	spell.randomize_stats(rarity)

func apply_to(stats:PlayerStats):
	stats.add_spell(spell.duplicate())
