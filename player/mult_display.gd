extends RichTextLabel

var prev_mult


func _on_player_madness_update(value):
	var mult = snapped(1+GameManager.player_stats.knowledge_mult*value/100,.5)
	if mult == prev_mult:return
	prev_mult = mult
	set_text(str("[font_size=64][shake rate=",mult*5," level=",mult*5," connected=1]Madness Mult X",mult,"[/shake][/font_size]"))
	if mult >=8:
		modulate = Color.RED
		set_text(str("[rainbow freq=1.0 sat=1.0 val=1.0]",get_text(),"[/rainbow]"))
	elif mult >= 6:
		modulate = Color.RED
	elif mult>= 4:
		modulate = Color.ORANGE
	elif mult>2:
		modulate = Color.YELLOW
	else:
		modulate = Color.WHITE
