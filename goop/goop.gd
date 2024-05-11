extends Node2D

var required_dist: float = 300
var despawn_dist:float = 3000
var enabled: bool = false
var distance: float = 0

func add_distance(movement):
	distance += movement
	if distance >= required_dist and !enabled:
		$AnimationPlayer.play("enable")
		enabled = true
	elif distance>=despawn_dist:
		$AnimationPlayer.play("despawn")
		await $AnimationPlayer.animation_finished
		queue_free()

func _on_area_2d_body_exited(body):
	if !body.is_in_group("player"):return
	body.overlaping_goop.erase(self)


func _on_area_2d_body_entered(body):
	if !body.is_in_group("player"):return
	body.overlaping_goop.append(self)
