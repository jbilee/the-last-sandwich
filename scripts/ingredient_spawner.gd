extends Node2D

signal add_to_stack(ingredient_instance)

var left_button_pressed = false
var right_button_pressed = false
var id = 0
@onready var left_queue = $LeftQueue
@onready var right_queue = $RightQueue
@onready var stack_sound = $StackSound
@onready var discard_sound = $DiscardSound
@onready var ingredient_scenes = [Global.breads["Bread"], Global.ingredients["Cheese"], Global.ingredients["Lettuce"], Global.ingredients["Tomato"], Global.ingredients["Meat"], Global.breads["Bread"]]

func _ready():
	for i in range(3):
		var left_ingredient = get_random_ingredient()
		left_queue.init(left_ingredient, i)
		var right_ingredient = get_random_ingredient()
		right_queue.init(right_ingredient, i)
	var left_hidden_spawn = get_random_ingredient()
	left_queue.spawn_on_left(left_hidden_spawn)
	var right_hidden_spawn = get_random_ingredient()
	right_queue.spawn_on_right(right_hidden_spawn)

func _input(event):
	if (!Global.playing): return
	if event is InputEventKey:
		if event.is_pressed():
			if event.keycode == KEY_LEFT or event.keycode == KEY_A:
				left_button_pressed = true
			elif event.keycode == KEY_RIGHT or event.keycode == KEY_D:
				right_button_pressed = true
		else:
			if event.keycode == KEY_LEFT or event.keycode == KEY_A:
				left_button_pressed = false
				if Input.is_key_pressed(KEY_CTRL):
					discard_ingredient("left")
				else:
					stack_ingredient("left")
			elif event.keycode == KEY_RIGHT or event.keycode == KEY_D:
				right_button_pressed = false
				if Input.is_key_pressed(KEY_CTRL):
					discard_ingredient("right")
				else:
					stack_ingredient("right")

func get_random_ingredient():
	var new_ingredient = ingredient_scenes.pick_random().instantiate()
	new_ingredient.name += str(id)
	id += 1
	return new_ingredient

func stack_ingredient(key):
	var ingredient_to_stack = left_queue.get_child(0) if key == "left" else right_queue.get_child(0)
	emit_signal("add_to_stack", ingredient_to_stack)

func discard_ingredient(key):
	var ingredient = left_queue.get_child(0) if key == "left" else right_queue.get_child(0)
	var new_ingredient = get_random_ingredient()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(ingredient, "position", ingredient.position + Vector2(0, 40), 0.03)
	tween.tween_property(ingredient, "modulate", Color(ingredient.modulate.r, ingredient.modulate.g, ingredient.modulate.b, 0), 0.08)
	await tween.finished
	discard_sound.play()
	if key == "left":
		left_queue.remove_child(ingredient)
		ingredient.queue_free()
		left_queue.animate_left_queue()
		left_queue.spawn_on_left(new_ingredient)
	if key == "right":
		right_queue.remove_child(ingredient)
		ingredient.queue_free()
		right_queue.animate_right_queue()
		right_queue.spawn_on_right(new_ingredient)

func _on_stack_stacked_ingredient(queue):
	stack_sound.play()
	var new_ingredient = get_random_ingredient()
	new_ingredient.scale = Vector2(0.7, 0.7)
	if queue == "LeftQueue":
		left_queue.animate_left_queue()
		left_queue.spawn_on_left(new_ingredient)
	else:
		right_queue.animate_right_queue()
		right_queue.spawn_on_right(new_ingredient)

func _on_stack_full_stack():
	pass # Replace with function body.
