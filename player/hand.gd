extends Node2D

func _process(delta):
	if get_global_mouse_position().x<=global_position.x:
		$Pistol.is_left.emit(true)
	else:
		$Pistol.is_left.emit(false)

func shoot():
	if !$Pistol:return
	$Pistol.shoot()

func reload():
	if !$Pistol:return
	$Pistol.reload()
