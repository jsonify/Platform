extends CharacterBody2D

@export var hp_max := 100
@export var hp := hp_max
@export var defense := 0
#@export var GRAVITY := 5

@export var SPEED := 300

@onready var sprite := $Sprite2D
@onready var collision_shape := $CollisionShape2D
@onready var animation_player := $AnimationPlayer

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	move()
	
func move():
	move_and_slide()
	
func die():
	queue_free()
