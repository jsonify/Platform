extends BoxBasic

const Righthorn = preload("res://collectibles/puzzle-objects/right_horn.tscn")

func _ready():
	Events.right_horn_box_activated.connect(_on_right_horn_box_activated)


func _on_body_entered(body):
	if body is Player:
		animation_player.play("opening")
		Events.emit_signal("right_horn_box_activated")
		$CollisionShape2D.set_deferred("disabled", true)
		

func _on_right_horn_box_activated():
	var right_horn = Righthorn.instantiate()
	var pink_box_position = $CollisionShape2D.position
	
	right_horn.position = pink_box_position 
	right_horn.position += Vector2(30, 5)
	print("right_horn position: ", position)
	call_deferred("add_child", right_horn)
