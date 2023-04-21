extends SignBase

@onready var sprite := $Sprite2D

func _ready():
	sprite.modulate.a = 0.0
	print(sprite.modulate.a)


func _on_body_entered(body):
	if body is Player:
		var tween = create_tween()
		tween.tween_property(sprite, "modulate:a", 1.0, 0.5)




func _on_body_exited(body):
	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 0.0, 0.5)
