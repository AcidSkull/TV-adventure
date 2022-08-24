extends KinematicBody2D

signal killed
signal coin_collected
signal heal
signal take_damage
signal change_health(health, heal_or_damage)

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
var coins = 2343564
var checkpoint

func _ready():
	checkpoint = global_position
	
	var HUD = get_parent().get_node("HUD")
	var music = get_parent().get_node("Music")
	var camera = get_parent().get_node("Camera2D")
	var _unused
	
	_unused = connect("coin_collected", HUD, "_on_Player_coin_collected")
	_unused = connect("change_health", HUD, "_on_change_health")
	
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
	var heal_or_damage
	
	if value < health:
		heal_or_damage = false
	else:
		heal_or_damage = true
	
	health = clamp(value, 0, MAX_HEALTH)
	emit_signal("change_health", health, heal_or_damage)
	if health == 0:
		kill()
		emit_signal("killed")
			
func kill():
	_set_health(MAX_HEALTH)
	position = checkpoint
	
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
		if area.is_in_group("sawblade"):
			var pos = area.position_to_return
			if pos.x != 0 and pos.y != 0:
				position = area.position_to_return
		damage()
	elif area.is_in_group("coin"):
		coins += 1
		emit_signal("coin_collected")
		area.queue_free()
	elif area.is_in_group("health"):
		_set_health(health + 1)
		emit_signal("heal")
		area.queue_free()

func setCheckpoint(FlagPosition):
	checkpoint = FlagPosition
