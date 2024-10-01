extends Control

@onready var score_label = $Score
@onready var timer_label = $Timer

func set_score_label():
	score_label.text = str(Global.score)

func set_timer_label(new_time):
	var time_string = get_time_string(new_time)
	timer_label.text = time_string

func get_time_string(seconds):
	var min_left = int(seconds / 60)
	var sec_left = seconds - min_left * 60
	return "%02d:%02d" % [min_left, sec_left]
