extends Node2D

export var is_on_floor = true
var floor_string

onready var ray = $RayCast2D
onready var animation = $AnimationPlayer
onready var detection_range = $DetectionRange

func _ready():
	if is_on_floor:
		floor_string = "floor"
		detection_range.scale.y = 1
	else:
		floor_string = "ceil"
		detection_range.scale.y = -1

func _on_DetectionRange_body_entered(body):
	if body.is_in_group("player"):
		animation.play("Opening_" + floor_string)

func _on_DetectionRange_body_exited(body):
	if body.is_in_group("player"):
		animation.play_backwards("Opening_" + floor_string)

func _on_AnimationPlayer_animation_finished():
	animation.stop()
