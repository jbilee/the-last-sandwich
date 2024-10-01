extends Node2D

var time_left = Global.TIME_LIMIT
@onready var stack_instance = $Stack
@onready var customer_spawner_instance = $CustomerSpawner
@onready var ui = $UI
@onready var hud = $UI/HUD
@onready var timer = $Timer
@onready var beep = $CountdownBeep
@onready var ring = $GameOverRing
@onready var money_effect = preload("res://scenes/money_effect.tscn")
@onready var annoyed_effect = preload("res://scenes/annoyed_effect.tscn")

func _ready():
	Global.playing = true
	hud.set_score_label()
	hud.set_timer_label(time_left)

func _on_stack_submit_order():
	var sandwich = stack_instance.get_children()
	var customer = customer_spawner_instance.get_child(0)
	var customer_order = customer.order_strings
	var sandwich_size = sandwich.size()
	var customer_order_size = customer_order.size()
	if sandwich_size != customer_order_size:
		customer.animate_failure()
		play_annoyed_effect()
		return
	var isCorrectDish = true;
	for i in range(customer_order_size):
		if !sandwich[i].get_name().begins_with(customer_order[i]):
			isCorrectDish = false;
	if isCorrectDish:
		stack_instance.accept_dish()
		var callable_test = Callable(self, "increase_time_left")
		customer.update_score(callable_test)
		Global.served += 1
		hud.set_score_label()
		play_money_effect()
	else:
		customer.animate_failure()
		play_annoyed_effect()

func increase_time_left(amount):
	time_left += amount
	hud.set_timer_label(time_left)

func play_money_effect():
	var effect_instance = money_effect.instantiate()
	self.add_child(effect_instance)

func play_annoyed_effect():
	var effect_instance = annoyed_effect.instantiate()
	self.add_child(effect_instance)

func _on_timer_timeout():
	time_left -= 1
	if (time_left <= 5 && time_left > 0):
		beep.play()
	if (time_left == 0):
		Global.playing = false
		hud.set_timer_label(time_left)
		timer.stop()
		ring.play()
		stop_music()
		await get_tree().create_timer(3).timeout
		return get_tree().change_scene_to_file("res://scenes/result_screen.tscn")
	hud.set_timer_label(time_left)

func stop_music():
	var bgm = $BGM
	bgm.stop()
