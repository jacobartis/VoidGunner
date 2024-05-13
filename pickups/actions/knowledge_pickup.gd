extends PickupAction

@export var knowledge: int = 10

func on_pickup(body):
	body.add_knowledge(knowledge)
