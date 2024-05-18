extends PickupAction

@export var knowledge: int = 50

func on_pickup(body):
	body.add_knowledge(knowledge)
