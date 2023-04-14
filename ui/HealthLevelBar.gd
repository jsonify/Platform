extends TextureProgressBar


func _ready():
	value = Game.playerHP


func _process(_delta):
	if Game.playerHP > 0:
		value = Game.playerHP

