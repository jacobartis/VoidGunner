extends PickupAction

@export var heal: float = 10

func on_pickup(body):
	body.health += heal
