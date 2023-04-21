extends SignBase

@onready var sprite := $Sprite2D

func _on_body_entered(body):
	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 1.0, 0.5)
	

func _on_body_exited(body):
	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 0.0, 1)
