extends EnemyAttack
class_name DashAttack

@export var distance: float
@export var speed: float
@export var cooldown: float

var current_time: float

func _process(delta):
	if current_time:
		current_time-=delta
	if current_time<0:
		current_time = 0

func attack(args:Dictionary):
	if current_time: return
	args["Body"].enter_dash(args["AttackDirection"],distance,speed)
	current_time = cooldown
