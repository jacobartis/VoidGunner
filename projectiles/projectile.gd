extends Node2D


var target_groups:Array = ["player"]
var damage:float = 1
var speed: float = 100
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	global_position += speed*direction.normalized()*delta


func _on_area_2d_body_entered(body):
	if target_groups.filter(func(group):return body.is_in_group(group)).is_empty():
		return
	body.hit(damage)
	queue_free()
