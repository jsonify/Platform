extends CharacterBody2D


@export var SPEED := 100.0
@export var JUMP_VELOCITY := -160.0
@export var JUMP_RELEASE_FORCE := -40
@export var MAX_SPEED := 75
@export var ACCELERATION := 10
@export var FRICTION := 10
@export var GRAVITY := 580
@export var ADDITIONAL_FALL_GRAVITY := 2
@export var THRUST := -1
@export var MAX_THRUST := 50

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


#func _physics_process(delta):
#	# Add the gravity.
#	apply_gravity(delta)
##	if not is_on_floor():
##		velocity.y += GRAVITY * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#
#	move_and_slide()

func apply_thrust():
	velocity.y = lerp(0, MAX_THRUST, THRUST)

func fast_fall():
	if velocity.y > 0:
		velocity.y += ADDITIONAL_FALL_GRAVITY

func apply_gravity(delta):
	velocity.y += GRAVITY * delta

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
