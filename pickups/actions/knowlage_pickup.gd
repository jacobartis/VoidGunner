extends PickupAction

@export var knowlage: int = 10

func on_pickup(body):
	body.add_knowlage(knowlage)
