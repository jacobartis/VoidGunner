extends Spell
class_name HealSpell

@export_category("Heal Stats")
@export var heal_amount: float = 20

func cast(body):
	body.health += heal_amount
	remaining = cooldown
