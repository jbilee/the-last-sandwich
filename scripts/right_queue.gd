extends Node2D

const RIGHT_SPAWN_POSITION = Vector2(1315, 535)
const RIGHT_QUEUE_POSITIONS = [Vector2(656, 560), Vector2(786, 590), Vector2(916, 560)]

func init(ingredient, i):
	ingredient.scale = Vector2(0.7, 0.7)
	self.add_child(ingredient)
	ingredient.global_position = RIGHT_QUEUE_POSITIONS[i]

func spawn_on_right(ingredient):
	ingredient.scale = Vector2(0.7, 0.7)
	self.add_child(ingredient)
	ingredient.global_position = RIGHT_SPAWN_POSITION

func animate_right_queue():
	var ingredients = self.get_children()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(ingredients[0], "position", RIGHT_QUEUE_POSITIONS[0], 0.08)
	tween.tween_property(ingredients[1], "position", RIGHT_QUEUE_POSITIONS[1], 0.08)
	tween.tween_property(ingredients[2], "position", RIGHT_QUEUE_POSITIONS[2], 0.08)
