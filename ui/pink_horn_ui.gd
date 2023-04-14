extends Sprite2D

func _ready():
	Events.pink_horn_collected.connect(_on_pink_horn_activated)

func _on_pink_horn_activated():
	visible = true
