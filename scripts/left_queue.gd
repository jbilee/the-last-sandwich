extends Node2D

const LEFT_SPAWN_POSITION = Vector2(-200, 535)
const LEFT_QUEUE_POSITIONS = [Vector2(336, 560), Vector2(206, 590), Vector2(76, 560)]

func init(ingredient, i):
	ingredient.scale = Vector2(0.7, 0.7)
	self.add_child(ingredient)
	ingredient.global_position = LEFT_QUEUE_POSITIONS[i]

func spawn_on_left(ingredient):
	ingredient.scale = Vector2(0.7, 0.7)
	self.add_child(ingredient)
	ingredient.global_position = LEFT_SPAWN_POSITION

func animate_left_queue():
	var ingredients = self.get_children()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(ingredients[0], "position", LEFT_QUEUE_POSITIONS[0], 0.08)
	tween.tween_property(ingredients[1], "position", LEFT_QUEUE_POSITIONS[1], 0.08)
	tween.tween_property(ingredients[2], "position", LEFT_QUEUE_POSITIONS[2], 0.08)
