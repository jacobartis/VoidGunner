extends Label


func _ready():
	GameManager.enemy_update.connect(update_text)

func update_text(val):
	set_text(str("Remaning: ",val))
