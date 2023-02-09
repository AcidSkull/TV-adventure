extends Control

onready var new_game = $Panel/ButtonContainer/NewGame
onready var load_level = $Panel/ButtonContainer/LoadLevel
onready var exit = $Panel/ButtonContainer/Exit

func _ready():
	new_game.connect("pressed", self, '_on_new_game_pressed')
	load_level.connect("pressed", self, '_on_load_level_pressed')
	exit.connect("pressed", self, '_on_exit_pressed')

func _on_new_game_pressed():
	print(1)

func _on_load_level_pressed():
	print(2)

func _on_exit_pressed():
	print(3)
