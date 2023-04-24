extends CharacterBody2D
class_name BaseEnemy

@onready var sprite := $Marker2D/Sprite2D
@onready var ledge_check := $Marker2D/LedgeCheck
@onready var marker_2D = $Marker2D

@export var normal_speed := 10

var can_patrol := false
var direction = Vector2.RIGHT

var player = null

func _physics_process(delta):
	detect_turn_around()
	patrol()
	move_and_slide()

func patrol():
	velocity = direction * normal_speed
	

func detect_turn_around():
	
	var found_wall = is_on_wall()
	var found_ground = !ledge_check.is_colliding()
	
	if found_wall or found_ground:
		direction *= -1
	
	if direction.x == 1:
		marker_2D.scale.x = 1
	else:
		marker_2D.scale.x = -1


