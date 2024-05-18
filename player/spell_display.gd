extends BoxContainer

var current_spell = null

func _on_spell_manager_new_spell_selected(spell):
	show()
	current_spell = spell
	$Name.set_text(str('"',InputMap.action_get_events("player_cast")[0].as_text().trim_suffix(" (Physical)"),'" to cast ',spell.name))
	$Cost.set_text(str("Cost: ",snapped(spell.cost,.1)))

func _process(delta):
	if !current_spell:return
	$Name/ChargeBar.material.set_shader_parameter("fill",1-(current_spell.remaining/current_spell.cooldown))
