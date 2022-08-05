extends KinematicBody2D
class_name Enemy

signal enemy_killed(position)

var velocity = Vector2.ZERO

export var speed = 50
export var moving_left = true
export var gravity = 1000.0

onready var l_ray = $RayCast2D
onready var animation = $AnimationPlayer

func _ready():
	var hurtbox = get_node("HurtBox")
	hurtbox.connect("body_entered", self, "_on_HurtBox_body_entered")
	var _random_var = connect("enemy_killed", get_parent(), "_on_Enemies_enemy_killed")

func _physics_process(delta):
	if l_ray.is_colliding():
		moving_left = !moving_left
		l_ray.scale.x = -l_ray.scale.x
	
	if moving_left:
		animation.play("Moving_left")
	else:
		animation.play("Moving_right")
	
	velocity.y += gravity * delta
	velocity.x = -speed if moving_left else speed
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_HurtBox_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
		emit_signal("enemy_killed", global_position)
