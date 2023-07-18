extends Button

onready var sound_effect = $AudioStreamPlayer

func _on_MenuButton_mouse_entered():
	sound_effect.play()
