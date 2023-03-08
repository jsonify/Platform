extends CharacterBody2D

@onready var ledge_check_right = $LedgeCheckRight
@onready var ledge_check_left = $LedgeCheckLeft

@onready var animated_sprite = $AnimatedSprite2D

#var direction := Vector2.RIGHT
var direction = 1

func _ready():
	if direction == 1:
		animated_sprite.flip_h = false

func _physics_process(delta):
	animated_sprite.play("move")
	handle_wall()
	handle_ledge()
	move_and_slide()

func handle_ledge():
	var found_ledge = not ledge_check_right.is_colliding() or not ledge_check_left.is_colliding() 
	if found_ledge:
		direction *= -1
		animated_sprite.flip_h = not animated_sprite.flip_h
	velocity.x = direction * 10

func handle_wall():
	if is_on_wall():
		direction *= -1
		animated_sprite.flip_h = not animated_sprite.flip_h
	velocity.x = direction * 10

func _on_hurtbox_area_entered(area):
	queue_free()
