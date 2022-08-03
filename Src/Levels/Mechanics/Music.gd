extends Node2D

func _on_Player_coin_collected():
	$CoinSound.play()

func _on_Player_heal():
	$HealSound.play()
