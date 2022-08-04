extends Node2D

onready var explosion_effect = get_parent().get_node("Effects/Explosion")

func _on_Enemies_enemy_killed(position):
	explosion_effect.start(position)
