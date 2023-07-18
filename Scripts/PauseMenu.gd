extends Control

onready var resume = $CenterContainer/VBoxContainer/Resume
onready var menu = $CenterContainer/VBoxContainer/MainMenu
onready var exit = $CenterContainer/VBoxContainer/Exit

func _ready():
	resume.connect("pressed", self, '_on_resume_pressed')
	menu.connect("pressed", self, '_on_menu_pressed')
	exit.connect("pressed", self, '_on_exit_pressed')

func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		if self.visible:
			hide()
			get_tree().paused = false
		else:
			show()
			get_tree().paused = true

func _on_resume_pressed():
	hide()
	get_tree().paused = false

func _on_menu_pressed():
	get_tree().paused = false
	var _tmp = get_tree().change_scene("res://Scenes/Mechanics/Menu.tscn")

func _on_exit_pressed():
	get_tree().quit()
