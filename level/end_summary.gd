extends Control

func _ready():
	GameManager.game_end.connect(show_stats)

func show_stats():
	$Text/Waves.set_text(str("You survived ",GameManager.wave," waves!"))
	$Text/Kills.set_text(str("Killed ",GameManager.kills," enemies."))
	$Text/Knowledge.set_text(str("Gained ",GameManager.total_knowledge," knowledge."))
	show()

func _on_play_again_pressed():
	GameManager.reset()
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()

func _on_main_menu_pressed():
	GameManager.reset()
	get_tree().change_scene_to_file("res://menus/main_menu/main_menu.tscn")
