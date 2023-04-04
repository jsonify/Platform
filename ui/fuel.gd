extends Label


func _process(delta):
	if Game.fuel_level > 0:
		text = "Fuel Level: " + str(Game.fuel_level).pad_decimals(2)
	else:
		text = "Fuel Level: 0.00"
