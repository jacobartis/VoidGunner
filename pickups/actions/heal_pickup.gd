extends PickupAction

@export var heal_percent: float = 5

func on_pickup(body):
	body.health += (heal_percent*(1+GameManager.wave/20))*body.max_health/100
