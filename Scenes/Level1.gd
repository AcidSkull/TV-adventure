extends Node2D

var score = 0


func _on_Coin_coin_collected():
	score += 1
	$CoinSound.play()
	var scoretext = "Score: " + String(score)
	print(scoretext)
