extends RigidBody2D

export (int) var speed = 85

signal player_hit

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var random_number = rng.randi_range(0, 4)
	
	$Sprite.frame = random_number

func _physics_process(delta):
	translate(Vector2(-speed * delta, 0))

func _on_Hitbox_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("player_hit")
