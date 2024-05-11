extends TextureProgressBar

@export var cooldown_timer: Timer

func _process(delta):
	if cooldown_timer.time_left >= max_value: 
		show()
		max_value = cooldown_timer.time_left
	value = max_value - cooldown_timer.time_left
	if value == max_value:
		max_value = 0
		hide()
