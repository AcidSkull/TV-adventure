extends CanvasLayer

func _on_Coin_coin_collected():
	var tmp = int($VBoxContainer/CoinContainer/Label.text) + 1
	$VBoxContainer/CoinContainer/Label.text = str(tmp)
