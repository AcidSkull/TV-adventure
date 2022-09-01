extends Enemy

onready var sprite = $Sprite
onready var deteciton_box = $DetectionBox
onready var chase_timer = $ChaseTimer

var player = null

func _ready():
	$AnimationPlayer.play("Moving")

func animation():
	if l_ray.is_colliding():
		moving_left = !moving_left
		l_ray.scale.x = -l_ray.scale.x
		hitbox.scale.x = -hitbox.scale.x
		deteciton_box.scale.x = -deteciton_box.scale.x
	
	if moving_left:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func moving(delta):
	if player != null:
		if player.position.x > position.x:
			velocity.x = speed
		else:
			velocity.x = -speed
	else:
		velocity.x = -speed if moving_left else speed
		
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_DetectionBox_body_entered(body):
	if body.is_in_group("player"):
		player = body
		speed = 145

func _on_DetectionBox_body_exited(body):
	if body.is_in_group("player"):
		chase_timer.start()

func _on_ChaseTimer_timeout():
	player = null
	speed = 45
