extends Spell
class_name HealSpell

@export_category("Heal Stats")
@export var heal_percent: float = 10

func get_printable_stats():
	var arr = super()
	arr.append(str("Heal Percent: ",snapped(heal_percent,0.1),"%"))
	return arr

func update_power(mult):
	heal_percent = clamp(heal_percent*sqrt(mult),0,95)

func cast(body):
	body.health += body.health/(100.0/heal_percent)
	remaining = cooldown
