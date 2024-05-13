extends Control

func update_stats(stats:PlayerStats):
	var weap_item = stats.weapon
	%WeaponTexture.set_texture(weap_item.item_texture)
	var weapon = weap_item.weapon_scene.instantiate()
	%FireRate.set_text(str("Rate of Fire: ",weapon.fire_rate))
	%Ammo.set_text(str("Ammo: ",weapon.max_ammo))
	%ReloadTime.set_text(str("Rate of Fire: ",weapon.reload_time))
	%Damage.set_text(str("Damage: ",weapon.damage))
	%SpreadAngle.set_text(str("Spread: ",weapon.max_angle))
	%ShotsPerAttack.set_text(str("Shots per Attack: ",weapon.shots_per_attack))
	%ShotSpeed.set_text(str("Shot velocity: ",weapon.speed))
	%Pierce.set_text(str("Pierce: ",weapon.pierce))
