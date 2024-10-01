extends Node2D

var customer_array_index = 0
@onready var customer_scene = [preload("res://scenes/customer.tscn"), preload("res://scenes/customer2.tscn")]
@onready var pattern_keys = Global.order_patterns.keys()

func _ready():
	spawn_customer()

func spawn_customer():
	var customer = customer_scene[customer_array_index].instantiate()
	create_order(customer)
	self.add_child(customer)
	customer.display_order()
	change_index()

func change_index():
	if customer_array_index == 0:
		customer_array_index = 1
	else:
		customer_array_index = 0

func remove_customer():
	var customer = self.get_child(0)
	customer.queue_free()

func create_order(customer):
	var order_key = pull_random_key()
	var order_pattern = Global.order_patterns[order_key]
	customer.store_order(order_pattern)

func pull_random_key():
	if Global.score >= 3000:
		return str(randi_range(26, 37))
	elif Global.score >= 1000:
		return str(randi_range(5, 25))
	else:
		return str(randi_range(1, 19))

func _on_stack_order_successful():
	var customer_instance = self.get_child(0)
	customer_instance.animate_success()
	await get_tree().create_timer(1).timeout
	remove_customer()
	spawn_customer()
