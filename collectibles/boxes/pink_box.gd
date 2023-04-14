extends BoxBasic

const Pinkhorn = preload("res://collectibles/puzzle-objects/pink_horn.tscn")

func _ready():
	Events.pink_horn_box_activated.connect(_on_pink_horn_box_activated)


func _on_body_entered(body):
	if body is Player:
		animation_player.play("opening")
		Events.emit_signal("pink_horn_box_activated")
		$CollisionShape2D.set_deferred("disabled", true)
		

func _on_pink_horn_box_activated():
	var pink_horn = Pinkhorn.instantiate()
	var pink_box_position = $CollisionShape2D.position
	
	pink_horn.position = pink_box_position 
	pink_horn.position += Vector2(30, 5)
	print("pink_horn position: ", position)
	call_deferred("add_child", pink_horn)
