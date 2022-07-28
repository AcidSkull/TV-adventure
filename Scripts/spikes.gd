extends Area2D

signal hurt_player

func _on_spikes_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("hurt_player")
