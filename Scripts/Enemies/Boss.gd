extends Node2D

onready var missle = preload("res://Scenes/Traps/Missle.tscn")

var phase = 0

var is_attacking: bool = false

func start_boss_fight():
	phase += 1
	is_attacking = true

func choose_attack(max_value: int) -> int:
	var rng = RandomNumberGenerator.new()
	var random_number = rng.randi_range(0, max_value)
	return random_number

func shoot_missles():
	pass

func _process(delta):
	if is_attacking:
		match phase:
			1:
				pass
