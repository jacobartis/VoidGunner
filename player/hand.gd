extends Node2D

#TODO
#Allow weapon swapping

func get_weapon():
	return $Pistol

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
