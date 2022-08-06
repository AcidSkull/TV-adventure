extends KinematicBody2D

export var is_on_floor = true
var can_fire = true
var floor_string

onready var ray = $RayCast2D
onready var animation = $AnimationPlayer
onready var detection_range = $DetectionRange
onready var cooldown = $CooldownTimer

var bullet = preload("res://Scenes/Traps/Bullet.tscn")

func _ready():
	if is_on_floor:
		floor_string = "floor"
		detection_range.scale.y = 1
	else:
		floor_string = "ceil"
		detection_range.scale.y = -1
		
func _physics_process(delta):
	if can_fire and ray.is_colliding():
		_spawn_bullet()
		can_fire = false
		cooldown.start()

func _spawn_bullet():
	var direction = Vector2.RIGHT.rotated(global_rotation)
	var projectile = bullet.instance()
	
	projectile.direction = direction
	projectile.global_position = ray.global_position
	projectile.add_collision_exception_with(self)
	
	add_child(projectile)

func _on_DetectionRange_body_entered(body):
	if body.is_in_group("player"):
		animation.play("Opening_" + floor_string)

func _on_DetectionRange_body_exited(body):
	if body.is_in_group("player"):
		animation.play_backwards("Opening_" + floor_string)

func _on_AnimationPlayer_animation_finished():
	animation.stop()

func _on_CooldownTimer_timeout():
	can_fire = true
