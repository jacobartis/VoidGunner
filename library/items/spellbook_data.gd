extends ItemData
class_name SpellbookItemData

@export_category("Spellbook Info")
@export var spell: Spell

func apply_to(stats:PlayerStats):
	stats.add_spell(spell.duplicate())
