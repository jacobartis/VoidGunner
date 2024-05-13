extends Spell
class_name HealSpell

@export_category("Heal Stats")
@export var heal_percent: float = 10

func update_power(mult):
	heal_percent = clamp(heal_percent/mult,0,95)

func cast(body):
	body.health += body.health/(100.0/heal_percent)
	remaining = cooldown
