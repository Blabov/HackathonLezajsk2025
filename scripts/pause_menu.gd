extends CanvasLayer

var paused := false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause") and paused == false:
		self.visible = true
		get_tree().paused = true
		paused = true
	elif Input.is_action_just_pressed("Pause") and paused == true:
		self.visible = false
		get_tree().paused = false
		paused = false

func _on_resume_button_button_up() -> void:
	self.visible = false
	get_tree().paused = false
	paused = false

func _on_quit_button_button_up() -> void:
	get_tree().quit()

func _on_main_menu_button_button_up() -> void:
	self.visible = false
	get_tree().paused = false
	paused = false
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
