extends Label

var display: float = 0

func _ready():
	GameManager.new_wave.connect(update_text)

func _process(delta):
	display = clamp(display-delta,0,INF)
	if !display:
		hide_display()
	else:
		modulate = Color.WHITE

func update_text(val):
	set_text(str("Wave: ",val))
	display = 5

func hide_display():
	var hide_tween = get_tree().create_tween()
	hide_tween.tween_property(self,"modulate",Color.TRANSPARENT,.25)
