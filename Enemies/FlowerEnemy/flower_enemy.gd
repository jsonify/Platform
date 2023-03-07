extends CharacterBody2D

@onready var ledge_check = $LedgeCheck
@onready var animated_sprite = $AnimatedSprite2D

#var direction := Vector2.RIGHT
var direction = 1

func _ready():
	if direction == 1:
		animated_sprite.flip_h = false

func _physics_process(delta):
	handle_wall_or_ledge()
#	if found_wall:
#		print(direction)
	handle_ledge()
	move_and_slide()

func handle_ledge():
	var found_ledge = not ledge_check.is_colliding() 
	if found_ledge:
		direction *= -1
		animated_sprite.flip_h = not animated_sprite.flip_h
	velocity.x = direction * 10
	

func handle_wall_or_ledge():
	if is_on_wall():
		direction *= -1
		animated_sprite.flip_h = not animated_sprite.flip_h
	velocity.x = direction * 10
	
	
	
