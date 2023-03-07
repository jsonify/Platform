extends CharacterBody2D

@onready var ledge_check = $LedgeCheck


var direction := Vector2.RIGHT

func _physics_process(delta):
	velocity = direction * 10
	handle_wall_or_ledge()
	move_and_slide()

func handle_wall_or_ledge():
	var found_wall = is_on_wall()
	var found_ledge = not ledge_check.is_colliding() 
	if found_wall or found_ledge:
		direction *= -1
		scale.x = -1
	
