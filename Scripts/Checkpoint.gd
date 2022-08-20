extends Area2D

signal checkpoint(position)

onready var animation = $AnimationPlayer

func _ready():
	var player = get_parent().get_node("Player")
	var _variable = connect("checkpoint", player, "setCheckpoint")

func _on_Checkpoint_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("checkpoint", global_position)
		animation.play("Waving")
