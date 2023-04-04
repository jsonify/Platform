extends TextureProgressBar


func _ready():
	value = Game.fuel_level


func _process(delta):
	if Game.fuel_level > 0:
		value = Game.fuel_level

