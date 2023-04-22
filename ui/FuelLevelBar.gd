extends TextureProgressBar


func _ready():
	value = Game.fuel_level
	visible = Game.jetpack
	Events.thrust_engaged.connect(_on_thrust_engaged)
	Events.thrust_not_engaged.connect(_on_thrust_not_engaged)


func _process(_delta):
	visible = Game.jetpack
	if Game.fuel_level > 0:
		value = Game.fuel_level
		


func _on_thrust_engaged():
	tint_progress = Color(0.48, 0.33, 0.94)

func _on_thrust_not_engaged():
	tint_progress = Color(0.43, 0.83, 0.52)
