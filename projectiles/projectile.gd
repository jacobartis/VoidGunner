extends Node2D

@export var damage:float = 1

var speed: float
var direction: Vector2

func _physics_process(delta):
	global_position += speed*direction.normalized()


func _on_area_2d_body_entered(body):
	if !body.is_in_group("player") and !body.is_in_group("enemy"): return
	body.hit(damage)
	queue_free()
