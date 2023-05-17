extends CharacterBody2D

@export var starting_move_direction := Vector2.LEFT
@export var movement_speed := 30.0
@export var hit_state : State

@onready var animation_tree := $AnimationTree
@onready var state_machine := $CharacterStateMachine
@onready var sprite := $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction : Vector2 = starting_move_direction
	if direction and state_machine.check_if_can_move():
		velocity.x = direction.x * movement_speed
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, movement_speed)

	if is_on_wall():
#		if direction.x == -sign(get_slide_collision(0).normal.x):
		if direction.x == -sign(get_slide_collision(0).get_normal().x):
			starting_move_direction = -starting_move_direction  # Reverse the direction

	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

	move_and_slide()
