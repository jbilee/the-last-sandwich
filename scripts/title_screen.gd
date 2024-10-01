extends Control

@onready var instructions_scene = preload("res://scenes/instructions.tscn")

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_exit_button_pressed():
	get_tree().quit()

func _on_how_to_button_pressed():
	var instructions = instructions_scene.instantiate()
	self.add_child(instructions)
