extends Camera2D

onready var player = get_parent().get_node("Player")
onready var animation = $AnimationPlayer

var decay = 0.8
var max_offset = Vector2(25, 55)
var max_roll = 0.1
var shake_strength = 0.0
var shake_power = 3

func _ready():
	randomize()
	animation.play("transition_in")	
	show()

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

func transition_out():
	animation.play("transition_out")

func that_one_function_to_final_cutscene():
	self.limit_left = 1320
	self.limit_right = 1624
	self.limit_bottom = -136
	self.limit_top = -305
	var beach = get_tree().root.get_node("Level4/Beach")
	beach.position.x = 1320
	beach.position.y = -300
	var tmp = get_tree().root.get_node("Level4/Platform")
	tmp.position.x = 2000

func anothe_function_for_final_cutscene():
	var tmp = get_tree().root.get_node("Level4/CutsceneController2")
	tmp.position.x = 2000
	
