extends Node2D



func _ready():
	Events.jetpack_collected.connect(_on_jetpack_collected)
	

func _on_jetpack_collected():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.75)
	visible = true
	

	
