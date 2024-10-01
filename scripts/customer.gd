extends Node2D

var order_scene
var order_strings
var order_points
@onready var animation_player = $AnimationPlayer

func store_order(pattern):
	order_scene = pattern.scene
	order_strings = pattern.ingredients
	order_points = pattern.points

func update_score(callback):
	Global.score += order_points
	if order_points >= 1000:
		callback.call(15)
	elif order_points >= 300:
		callback.call(5)

func display_order():
	var order_instance = order_scene.instantiate()
	order_instance.global_position = Vector2(146, 290)
	self.add_child(order_instance)

func animate_success():
	animation_player.play("Bounce")

func animate_failure():
	animation_player.play("Shake")
