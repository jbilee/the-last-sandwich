extends Control

@onready var final_score_label = $FinalScore
@onready var serve_count_label = $ServeCount

func _ready():
	final_score_label.text = "Score: " + str(Global.score)
	serve_count_label.text = "Sandwiches Served: " + str(Global.served)

func _on_retry_button_pressed():
	reset_scores()
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func reset_scores():
	Global.score = 0
	Global.served = 0
