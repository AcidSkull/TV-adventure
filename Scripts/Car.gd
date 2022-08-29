extends RigidBody2D

export (int) var speed = 85
export (Vector2) var position_to_return = Vector2(500, 650)

signal player_hit(pos)

onready var player = get_parent().get_node("Player")

func _ready():
	var _unused_variable = connect("player_hit", player, "on_car_hit")
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var random_number = rng.randi_range(0, 4)
	
	$Sprite.frame = random_number

func _physics_process(delta):
	translate(Vector2(-speed * delta, 0))

func _on_Hitbox_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("player_hit", position_to_return)

func _on_Hitbox_area_entered(area):
	if area.is_in_group("despawn"):
		queue_free()
