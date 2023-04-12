extends TextureProgressBar


func _ready():
	value = Game.fuel_level
	visible = Game.jetpack


func _process(delta):
	visible = Game.jetpack
	if Game.fuel_level > 0:
		value = Game.fuel_level
