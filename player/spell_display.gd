extends Label


func _on_spell_manager_new_spell_selected(spell):
	set_text(spell.name)
