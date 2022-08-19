extends CanvasLayer

var images

onready var label = $VBoxContainer/CoinContainer/Label

func _ready():
	var max_images = get_parent().get_node("Player").MAX_HEALTH
	var life_container = $VBoxContainer/LifeContainer
	
	for _i in range(0, max_images):
		var texture_rect = TextureRect.new()
		texture_rect.texture = load("res://Assets/Textures/Collectibles/heart_point.png")
		life_container.add_child(texture_rect)
	
	images = $VBoxContainer/LifeContainer.get_children()

func _on_Player_take_damage():
	for i in range(images.size() - 1, -1 , -1):
		if images[i].texture.resource_path != "res://Assets/Textures/HUD/blank_heart.png":
			images[i].texture = load("res://Assets/Textures/HUD/blank_heart.png")
			break

func _on_Player_heal():
	for image in images:
		if image.texture.resource_path != "res://Assets/Textures/Collectibles/heart_point.png":
			image.texture = load("res://Assets/Textures/Collectibles/heart_point.png")
			break

func _on_Player_coin_collected():
	var tmp = int(label.text) + 1
	label.text = str(tmp)
