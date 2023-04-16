extends Sprite2D

func _ready():
	Events.right_horn_collected.connect(_on_right_horn_activated)

func _on_right_horn_activated():
	visible = true
