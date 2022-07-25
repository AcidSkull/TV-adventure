extends Area2D

signal heart_collected

func _on_Health_point_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("heart_collected")
		queue_free()
