extends KinematicBody2D

export var speed = 150.0
export var jump_strength = 250.0
export var gravity = 1000.0

var velocity = Vector2.ZERO
var facing_right = true

var coins = 0
var health = 5

func _ready():
	$AnimatedSprite.animation = "Idle_right"
	
func add_coin():
	coins += 1
	print(coins)
	
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
	
	
