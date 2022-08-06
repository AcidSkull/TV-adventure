extends KinematicBody2D

export var is_on_floor = true
var can_fire = true
var floor_string

onready var ray = $RayCast2D
onready var animation = $AnimationPlayer
onready var detection_range = $DetectionRange
onready var cooldown = $CooldownTimer

var bullet = preload("res://Scenes/Traps/Bullet.tscn")
var target = null

func _ready():
	if is_on_floor:
		floor_string = "floor"
		detection_range.scale.y = 1
		ray.scale.y = -50
	else:
		floor_string = "ceil"
		detection_range.scale.y = -1
		ray.scale.y = 50
		

func fire():
	var bullet_instance = bullet.instance()
	
	bullet_instance.position = get_global_position()
	bullet_instance.target = target
	
	get_parent().add_child(bullet_instance)
	
	cooldown.start()

func _on_DetectionRange_body_entered(body):
	if body.is_in_group("player"):
		animation.play("Opening_" + floor_string)
		target = body

func _on_DetectionRange_body_exited(body):
	if body.is_in_group("player"):
		animation.play_backwards("Opening_" + floor_string)
		target = null


func _on_CooldownTimer_timeout():
	if target != null:
		fire()
