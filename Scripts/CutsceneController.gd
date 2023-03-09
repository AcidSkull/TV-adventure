extends Node2D

onready var animation = get_parent().get_node("AnimationPlayer")

func start(player):
	player.can_move = false
	animation.play("cutscene")
	yield(animation, "animation_finished")
	player.can_move = true
