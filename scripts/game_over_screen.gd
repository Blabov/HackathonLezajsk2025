extends CanvasLayer


func _on_restart_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_button_button_up() -> void:
	get_tree().quit()


func _on_main_menu_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
