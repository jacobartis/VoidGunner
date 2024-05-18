extends Spell
class_name ExplodeVoidSpell

@export_category("Explode Void Stats")
@export var damage: float = 10

func get_printable_stats():
	var arr = super()
	arr.append(str("Damage: ",snapped(damage,0.1)))
	return arr

func update_power(mult):
	damage = damage*sqrt(mult)

func cast(body):
	var goops: Array = body.get_tree().get_nodes_in_group("goop").filter(func(goop): return goop.enabled)
	var world = body.get_tree().get_first_node_in_group("goop_home")
	for goop in goops:
		var explosion = preload("res://projectiles/purple_explosion.tscn").instantiate()
		explosion.damage = damage
		explosion.global_position = goop.global_position
		explosion.target_groups = ["enemy"]
		world.add_child(explosion)
		goop.queue_free()
