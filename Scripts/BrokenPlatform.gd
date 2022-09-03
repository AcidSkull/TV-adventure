extends Area2D

onready var animation = $AnimationPlayer
onready var collision = $CollisionShape2D
onready var collision2 = $StaticBody2D/CollisionShape2D
onready var timer = $Timer
onready var sprite = $Sprite

func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			animation.play("Breaking")
			
			yield(animation, "animation_finished")
			
			collision.disabled = true
			collision2.disabled = true
			timer.start()
		else:
			animation.play("Idle")
			collision.disabled = false
			collision2.disabled = false

func _on_Timer_timeout():
	animation.play_backwards("Breaking")
	collision.disabled = false
	collision2.disabled = false
