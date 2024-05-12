extends Spell
class_name ScreenDamageSpell

@export_category("Screen Damage Stats")
@export var damage: float = 20

func cast(body):
	body.get_tree().call_group("enemy","hit",damage)
	remaining = cooldown
