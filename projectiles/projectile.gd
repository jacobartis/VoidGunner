extends Node2D

@export var animated: bool = false
@export var life_time: float = 10
@export var look_towards: bool = false

var target_groups:Array = ["player"]
var damage:float = 1
var speed: float = 100
var direction: Vector2 = Vector2.ZERO

func _ready():
	if !animated:return
	$AnimationPlayer.play("attack")

func _process(delta):
	life_time -= delta
	if life_time<=0:
		queue_free()

func _physics_process(delta):
	global_position += speed*direction.normalized()*delta
	if look_towards:
		look_at(global_position+direction.normalized())

func _on_area_2d_body_entered(body):
	if target_groups.filter(func(group):return body.is_in_group(group)).is_empty():
		return
	body.hit(damage)
	queue_free()
