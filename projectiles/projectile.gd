extends Node2D

signal time_expired()
signal target_hit()

@export var animated: bool = false
@export var life_time: float = 10
@export var look_towards: bool = false
@export var pierce: int = 0
@export var speed_variation: CurveTexture
@export var target_groups:Array = ["player"]
var damage:float = 1
var speed: float = 100
var curve_speed: float = 0
var direction: Vector2 = Vector2.ZERO
var current_time: float = 0

var despawning: bool = false

func _ready():
	if !animated:return
	$AnimationPlayer.play("attack")

func _process(delta):
	current_time += delta
	if current_time>=life_time and !despawning:
		despawn_anim()
	if !speed_variation: return
	var offset = life_time
	curve_speed = speed*speed_variation.curve.sample(current_time/life_time)

func despawn_anim():
	if animated:
		$AnimationPlayer.play("despawn")
		await $AnimationPlayer.animation_finished
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(self,"scale",Vector2.ZERO,.1)
		await tween.finished
	time_expired.emit()
	queue_free()

func _physics_process(delta):
	if speed_variation:
		global_position += curve_speed*direction.normalized()*delta
	else:
		global_position += speed*direction.normalized()*delta
	if look_towards:
		look_at(global_position+direction.normalized())

func _on_area_2d_body_entered(body):
	if target_groups.filter(func(group):return body.is_in_group(group)).is_empty():
		return
	body.hit(damage)
	target_hit.emit()
	if pierce<=0: queue_free()
	pierce -= 1
