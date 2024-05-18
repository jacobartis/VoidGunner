extends Spell
class_name ScreenDamageSpell

@export_category("Screen Damage Stats")
@export var damage: float = 20

func get_printable_stats():
	var arr = super()
	arr.append(str("Damage: ",snapped(damage,0.1)))
	return arr

func cast(body):
	body.get_tree().call_group("enemy","hit",damage)
	remaining = cooldown
