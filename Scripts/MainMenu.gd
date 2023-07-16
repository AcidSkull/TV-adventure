extends Control

onready var new_game = $Panel/ButtonContainer/NewGame
onready var load_level = $Panel/ButtonContainer/LoadLevel
onready var exit = $Panel/ButtonContainer/Exit
onready var level1 = $Panel/LevelButtonContainer/level1
onready var level2 = $Panel/LevelButtonContainer/level2
onready var level3 = $Panel/LevelButtonContainer/level3
onready var level4 = $Panel/LevelButtonContainer/level4
onready var return_btn = $Panel/LevelButtonContainer/return
onready var button_container = $Panel/ButtonContainer
onready var level_button_container = $Panel/LevelButtonContainer

func _ready():
	new_game.connect("pressed", self, '_on_new_game_pressed')
	load_level.connect("pressed", self, '_on_load_level_pressed')
	exit.connect("pressed", self, '_on_exit_pressed')
	level1.connect("pressed", self, '_on_level1_pressed')
	level2.connect("pressed", self, '_on_level2_pressed')
	level3.connect("pressed", self, '_on_level3_pressed')
	level4.connect("pressed", self, '_on_level4_pressed')
	return_btn.connect("pressed", self, '_on_return_pressed')

func _on_new_game_pressed():
	var _tmp = get_tree().change_scene("res://Scenes/Levels/Level1.tscn")

func _on_load_level_pressed():
	button_container.hide()
	level_button_container.show()

func _on_exit_pressed():
	get_tree().quit()

func _on_level1_pressed():
	var _tmp = get_tree().change_scene("res://Scenes/Levels/Level1.tscn")

func _on_level2_pressed():
	var _tmp = get_tree().change_scene("res://Scenes/Levels/Level2.tscn")
	
func _on_level3_pressed():
	var _tmp = get_tree().change_scene("res://Scenes/Levels/Level3.tscn")
	
func _on_level4_pressed():
	var _tmp = get_tree().change_scene("res://Scenes/Levels/Level4.tscn")
	
func _on_return_pressed():
	level_button_container.hide()
	button_container.show()
