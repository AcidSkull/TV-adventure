extends StaticBody2D

onready var collision = $CollisionShape2D
onready var open_sound = $AudioStreamPlayer
onready var sprite = $Sprite
onready var label = $Label

export (int) var coins_to_open = 0
var is_open = false

func _ready():
	label.text = String(coins_to_open)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and !is_open:
		if body.coins >= coins_to_open:
			open_sound.play()
			collision.set_deferred("disabled", true)
			sprite.frame = 1
			label.hide()
			is_open = true
