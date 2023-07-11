extends Node2D

onready var tractor = preload("res://Scenes/Enemies/Tractor.tscn")
onready var android = preload("res://Scenes/Enemies/Android.tscn")

onready var player = get_tree().root.get_node("Level4/Player")
onready var enemies = get_tree().root.get_node("Level4/Enemies")
onready var spawn1 = $Spawn1
onready var spawn2 = $Spawn2
onready var cooldown = $attackLatency

var turn = 0

func start_boss_fight():
	spawn_enemies()
	cooldown.start()
	get_tree().root.get_node("Level4/CutsceneController").queue_free()
	player.can_move = true
	get_tree().root.get_node("Level4/Blockade").show()

func spawn_enemies():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_number = rng.randi_range(1, 2)
	var enemy
	match random_number:
		1:
			enemy = tractor.instance()
		2:
			enemy = android.instance()
	
	rng.randomize()
	random_number = rng.randi_range(1, 2)
	match random_number:
		1:
			enemy.position = spawn1.position
		2:
			enemy.position = spawn2.position
	enemies.add_child(enemy)

func _on_attackLatency_timeout():
	if turn == 15:
		cooldown.stop()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_number = rng.randi_range(2, 5)
	for _i in range(0, random_number):
		yield(get_tree().create_timer(0.2), "timeout")
		spawn_enemies()
	turn += 1
