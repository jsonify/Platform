extends Node2D


func _ready():
	Events.cave_entered.connect(_on_cave_entered)

func _on_cave_entered():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.75)
	visible = true
	
