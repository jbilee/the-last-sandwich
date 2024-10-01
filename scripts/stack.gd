extends Node2D

signal stacked_ingredient(queue)
signal full_stack
signal submit_order
signal order_successful

var base_position = Vector2(496, 520)
var base_modulate = Color(self.modulate.r, self.modulate.g, self.modulate.b, 1)

func _input(event):
	if (!Global.playing): return
	if event is InputEventKey:
		if Input.is_action_just_released("down_button"):
			if Input.is_key_pressed(KEY_CTRL):
				discard_all()
			else:
				remove_from_stack()
		if Input.is_action_just_released("up_button"):
			submit_stack()

func remove_from_stack():
	var ingredients = self.get_children()
	if ingredients.size() == 0:
		return
	var last_index = ingredients.size() - 1
	ingredients[last_index].queue_free()

func discard_all():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", base_position + Vector2(0, 40), 0.03)
	tween.tween_property(self, "modulate", Color(self.modulate.r, self.modulate.g, self.modulate.b, 0), 0.08)
	await tween.finished
	clear_stack()

func submit_stack():
	var ingredients = self.get_children()
	if ingredients.size() == 0: return
	emit_signal("submit_order")

func accept_dish():
	emit_signal("order_successful")
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", base_position + Vector2(0, -40), 0.03)
	tween.tween_property(self, "modulate", Color(self.modulate.r, self.modulate.g, self.modulate.b, 0), 0.08)
	await tween.finished
	clear_stack()

func clear_stack():
	var stack = self.get_children()
	for child in stack:
		child.queue_free()
	self.position = base_position
	self.set_modulate(base_modulate)

func _on_ingredient_spawner_add_to_stack(ingredient_instance):
	var parent = ingredient_instance.get_parent()
	var parent_name = parent.get_name()
	var stacked_ingredients = self.get_children()
	var stack_size = stacked_ingredients.size()
	if stack_size == Global.SANDWICH_HEIGHT: return emit_signal("full_stack")
	var last_ingredient_position = Vector2(0, 0) if stack_size == 0 else stacked_ingredients[stack_size - 1].position
	parent.remove_child(ingredient_instance)
	self.add_child(ingredient_instance)
	ingredient_instance.scale = Vector2(1, 1)
	ingredient_instance.position = last_ingredient_position + Vector2(0, -15)
	emit_signal("stacked_ingredient", parent_name)
