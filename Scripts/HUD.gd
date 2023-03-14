extends CanvasLayer

var images
var max_health

onready var label = $VBoxContainer/CoinContainer/Label

func _ready():
	max_health = get_parent().get_node("Player").MAX_HEALTH
	var life_container = $VBoxContainer/LifeContainer
	
	for _i in range(0, max_health):
		var texture_rect = TextureRect.new()
		texture_rect.texture = load("res://Assets/Textures/Collectibles/heart_point.png")
		life_container.add_child(texture_rect)
	
	images = $VBoxContainer/LifeContainer.get_children()
			
func _on_change_health(health, heal_or_damage):
	health = clamp(health, 0, max_health)
	
	if heal_or_damage == true:
		for i in range(health):
			images[i].texture = load("res://Assets/Textures/Collectibles/heart_point.png")
	else:
		images[health].texture = load("res://Assets/Textures/HUD/blank_heart.png")

func _on_Player_coin_collected(amount: int):
	label.text = str(amount)
