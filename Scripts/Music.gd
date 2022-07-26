extends Node2D

func _on_Health_point_heart_collected():
	$HealSound.play()


func _on_Coin_coin_collected():
	$CoinSound.play()
