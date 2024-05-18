extends HBoxContainer

signal awaiting_input()
signal recived_input()

@export var control_name:StringName = "None"

var listening: bool = false

func get_key():
	if !InputMap.has_action(control_name):return null
	return InputMap.action_get_events(control_name)[0]

func _draw():
	$Label.set_text(control_name.replace("_"," "))
	if !InputMap.has_action(control_name):
		queue_free()
		return
	var text = InputMap.action_get_events(control_name)[0].as_text()
	if " (Physical)" in text:
		text = text.trim_suffix(" (Physical)")
	$Button.set_text(text)

func _on_button_pressed():
	awaiting_input.emit()
	listening = true

func _input(event):
	if !listening or !event is InputEventKey:return
	if !event.is_pressed():return
	recived_input.emit()
	listening = false
	if event.is_match(get_key()):
		return
	if !Settings.is_unique(event):
		Settings.duplicate_popup()
		return
	InputMap.action_erase_events(control_name)
	InputMap.action_add_event(control_name,event)
	queue_redraw()
