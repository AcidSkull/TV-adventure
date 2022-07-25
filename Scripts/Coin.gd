extends Area2D

signal coin_collected

func _ready():
	$AnimationPlayer.play("Spinning")
	connect("on_body_entered", self, "_on_body_entered")

func _on_Coin_body_entered(body):
	if body.is_in_group("player"):
		if body.has_method("add_coin"):
			body.add_coin()
			$AudioStreamPlayer.play()
			queue_free()
	
