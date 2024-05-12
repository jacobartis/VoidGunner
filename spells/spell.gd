extends Resource
class_name Spell

@export_category("Spell Basics")
@export var name: String = "PlaceholderSpell"
@export var cost: float = 10
@export var cooldown: float = 5

var remaining: float = 0

func can_cast():
	return remaining<=0

func process(delta):
	if remaining>0:
		remaining -= delta
	else:
		remaining = 0

func cast(body):
	remaining = cooldown
