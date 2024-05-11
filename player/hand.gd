extends Node2D


func shoot():
	if !$Pistol:return
	$Pistol.shoot()
