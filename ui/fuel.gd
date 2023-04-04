extends Label


func _process(delta):
	if Game.fuel_level > 0:
		text = str(Game.fuel_level).pad_decimals(2) + "%"
	else:
		text = "0.00%"
