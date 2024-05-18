extends Control

var hp:float
var max_hp:float

func health_change(value):
	$Health.value = value
	hp = value
	$HealthLabel.set_text(str("Health: ",snapped(hp,.1),"/",snapped(max_hp,.1)))

func max_health_change(value):
	max_hp = value
	$HealthLabel.set_text(str("Health: ",snapped(hp,.1),"/",snapped(max_hp,.1)))

func madness_change(value):
	$Madness.value = value
	$MadnessLabel.set_text(str("Madness: ",snapped(value,.1)))
