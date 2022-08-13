extends Camera2D

onready var player = get_parent().get_node("Player")

var decay = 0.8
var max_offset = Vector2(25, 55)
var max_roll = 0.1
var shake_strength = 0.0
var shake_power = 3

func _ready():
	randomize()

func _process(delta):
	position.x = player.position.x
	position.y = player.position.y - 30
	
	# Shaking screen
	if shake_strength:
		shake_strength = max(shake_strength - decay * delta, 0)
		shake()

func shake():
	var amount = pow(shake_strength, shake_power)
	rotation = max_roll * amount * rand_range(-1, 1)
	offset.x = max_offset.x * amount * rand_range(-1, 1)
	offset.y = max_offset.y * amount * rand_range(-1, 1)
	
func add_shake_strength():
	shake_strength = min(shake_strength + 0.4, 1.0)
