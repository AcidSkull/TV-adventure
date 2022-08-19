extends KinematicBody2D

signal take_damage
signal heal
signal killed
signal coin_collected

onready var animation = $AnimationPlayer
onready var animationBlink = $BlinkAnimation
onready var invulnerable_timer = $InvulnerableEffect
onready var coyote_timer = $CoyoteTimer

onready var health = MAX_HEALTH

export (float) var speed = 150.0
export (float) var jump_strength = 175.0
export (float) var gravity = 1800.0
export (int) var MAX_HEALTH = 5

var velocity = Vector2.ZERO
var facing_right = true
var coins = 0

func _ready():
	var HUD = get_parent().get_node("HUD")
	var music = get_parent().get_node("Music")
	var camera = get_parent().get_node("Camera2D")
	var _unused
	
	_unused = connect("coin_collected", HUD, "_on_Player_coin_collected")
	_unused = connect("heal", HUD, "_on_Player_heal")
	_unused = connect("take_damage", HUD, "_on_Player_take_damage")
	
	_unused = connect("coin_collected", music, "_on_Player_coin_collected")
	_unused = connect("heal", music, "_on_Player_heal")
	
	_unused = connect("take_damage", camera, "add_shake_strength")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
		facing_right = true
		animation.play("Walking_right")
	elif Input.is_action_pressed("move_left"):
		velocity.x = -1
		facing_right = false
		animation.play("Walking_left")
	else:
		velocity.x = 0
		if facing_right:
			animation.play("Idle_right")
		else:
			animation.play("Idle_left")
	
	velocity.x = velocity.x * speed
	velocity.y += gravity * delta
	
	# Jumping
	if Input.is_action_pressed("jump") and (is_on_floor() or !coyote_timer.is_stopped()):
		velocity.y = -jump_strength
			
		
	# Checking if player is in air to play animation of jumping
	if !is_on_floor():
		if facing_right:
			animation.play("Jump_right")
		else:
			animation.play("Jump_left")
	
	# Moving player
	var was_on_floor = is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if was_on_floor && !is_on_floor():
		coyote_timer.start()

func _set_health(value):
	health = clamp(value, 0, MAX_HEALTH)
	if health == 0:
		kill()
		emit_signal("killed")
			
func kill():
	print("Dead")
	
func damage():
	if invulnerable_timer.is_stopped():
		invulnerable_timer.start()
		_set_health(health - 1)
		emit_signal("take_damage")
		animationBlink.play("Blink")

func _on_InvulnerableEffect_timeout():
	animationBlink.play("Stop")

func _on_HurtBox_area_entered(area):
	if area.is_in_group("hitbox"):
		damage()
	elif area.is_in_group("coin"):
		coins += 1
		emit_signal("coin_collected")
		area.queue_free()
	elif area.is_in_group("health"):
		_set_health(health + 1)
		emit_signal("heal")
		area.queue_free()
