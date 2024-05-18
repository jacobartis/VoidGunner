extends Control


func update_stats(stats:PlayerStats):
	clear()
	var total_container = VBoxContainer.new()
	add_child(total_container)
	for spell in stats.spells:
		var container = VBoxContainer.new()
		total_container.add_child(container)
		for stat in spell.get_printable_stats():
			var label = Label.new()
			label.set_text(stat)
			container.add_child(label)

func clear():
	for child in get_children():
		child.queue_free()
