extends Area2D

onready var timer = $Timer

export (Vector2) var position_to_return_for_cars

var car = preload("res://Scenes/Traps/Car.tscn")
var speed = [125, 145, 165, 185]
var speed_length = speed.size() - 1
var rng = RandomNumberGenerator.new()

func _on_Timer_timeout():
	var car_instance = car.instance()
	
	car_instance.position = global_position
	car_instance.position_to_return.x = position_to_return_for_cars.x
	car_instance.position_to_return.y = position_to_return_for_cars.y
	car_instance.speed = speed[rng.randi_range(0, speed_length)]
	
	get_parent().add_child(car_instance)
	
	timer.start(rng.randi_range(1, 3))
