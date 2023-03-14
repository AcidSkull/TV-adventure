extends Node2D

onready var animation = get_parent().get_node("AnimationPlayer")
export (String) var scene_to_change
export (int) var maximum_coins

func start(player):
	if maximum_coins <= player.coins:
		player.can_move = false
		animation.play("cutscene")
		yield(animation, "animation_finished")
		player.can_move = true
		var _tmp = get_tree().change_scene("res://Scenes/Levels/" + scene_to_change + ".tscn")
	
