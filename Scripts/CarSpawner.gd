extends Area2D

onready var timer = $Timer

var car = preload("res://Scenes/Traps/Car.tscn")

func _on_Timer_timeout():
	var car_instance = car.instance()
	car_instance.position = global_position
	
	get_parent().add_child(car_instance)
	
	timer.start()
