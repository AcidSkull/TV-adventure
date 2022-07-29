extends CanvasLayer

onready var images = $VBoxContainer/LifeContainer.get_children()
onready var label = $VBoxContainer/CoinContainer/Label

func _on_Coin_coin_collected():
	var tmp = int(label.text) + 1
	label.text = str(tmp)

func _on_Player_take_damage():
	for i in range(images.size() - 1, -1 , -1):
		if images[i].texture.resource_path != "res://Assets/Textures/blank_heart.png":
			images[i].texture = load("res://Assets/Textures/blank_heart.png")
			break


func _on_Player_heal():
	for image in images:
		if image.texture.resource_path != "res://Assets/Textures/heart_point.png":
			image.texture = load("res://Assets/Textures/heart_point.png")
			break
