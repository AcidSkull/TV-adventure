extends Particles2D

func start(pos):
	global_position = pos
	$AudioStreamPlayer.play()
	emitting = true
