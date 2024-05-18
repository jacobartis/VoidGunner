extends Label


func _ready():
	GameManager.round_timer_update.connect(update_text)

func update_text(val):
	set_text(str("Time left: ",snappedf(val,.1)))

