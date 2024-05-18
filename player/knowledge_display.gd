extends Label

func _ready():
	GameManager.knowledge_update.connect(update)

func update(val):
	set_text(str("Knowledge: ",val))
