extends KinematicBody2D

signal health_update(health)
signal killed

export var speed = 150.0
export var jump_strength = 250.0
export var gravity = 1000.0

var velocity = Vector2.ZERO
var facing_right = true

var coins = 0
export (int) var MAX_HEALTH = 5
onready var health = MAX_HEALTH setget _set_health
onready var invulnerable_timer = $InvulnerableEffect

func _ready():
	$AnimatedSprite.animation = "Idle_right"
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
		facing_right = true
		$AnimatedSprite.play("Walking_right")
	elif Input.is_action_pressed("move_left"):
		velocity.x = -1
		facing_right = false
		$AnimatedSprite.play("Walking_left")
	else:
		velocity.x = 0
		if facing_right:
			$AnimatedSprite.play("Idle_right")
		else:
			$AnimatedSprite.play("Idle_left")
	
	velocity.x = velocity.x * speed
	velocity.y += gravity * delta
	
	# Jumping
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_strength
		
	# Checking if player is in air to play animation of jumping
	if !is_on_floor():
		if facing_right:
			$AnimatedSprite.play("Jump_right")
		else:
			$AnimatedSprite.play("Jump_left")
	
	# Moving player
	velocity = move_and_slide(velocity, Vector2.UP)
	
func _on_Coin_coin_collected():
	coins += 1

func _on_Health_point_heart_collected():
	_set_health(health + 1)

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, MAX_HEALTH)
	if health != prev_health:
		emit_signal("health_update", health)
		if health == 0:
			kill()
			emit_signal("killed")
			
func kill():
	print("Dead")
	
func damage(amount):
	if invulnerable_timer.is_stopped():
		invulnerable_timer.start()
		_set_health(health - amount)

func _on_spikes_body_entered(body):
	damage(1)
