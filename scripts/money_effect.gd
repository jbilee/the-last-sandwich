extends Node2D

@onready var animation = $AnimationPlayer

func _ready():
	animation.play("Slide")
	await get_tree().create_timer(0.5).timeout
	queue_free()
