extends RigidBody2D

export (int) var speed = 85

var position_to_return = Vector2(0, 0)

signal player_hit

onready var player = get_tree().root.get_node("Level2/Player")

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
		emit_signal("player_hit")

func _on_Hitbox_area_entered(area):
	if area.is_in_group("despawn"):
		queue_free()
