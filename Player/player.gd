extends CharacterBody2D

class_name Player

@export var SPEED := 100.0
@export var JUMP_VELOCITY := -160.0
@export var JUMP_RELEASE_FORCE := -40
@export var MAX_SPEED := 75
@export var ACCELERATION := 10
@export var FRICTION := 10
@export var GRAVITY := 5
@export var ADDITIONAL_FALL_GRAVITY := 2
@export var THRUST := -1
@export var MAX_THRUST := 50

#@onready var animated_sprite := $AnimatedSprite2D
@onready var animation_player := $AnimationPlayer

enum {
	IDLE,
	RUN,
	JUMP,
	FALL,
	FLYING
}

var state = FALL

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y = Input.get_axis("ui_up", "ui_down")
	
	match state:
		IDLE:
			idle_state(input)
		RUN:
			run_state(input)
		JUMP:
			jump_state(input)
		FALL:
			fall_state()
		FLYING:
			flying_state(input)
	
#
#	if Input.is_action_pressed("ui_up"):
#		apply_thrust()
		
#	if input.x == 0:
#		animation_player.play("Idle")
#		apply_friction()
#	else:
#		animation_player.play("Run")
#
#		apply_acceleration(input.x)
		
	
#	if is_on_floor():
#		animation_player.play("Idle")
		
#	else:
#		if Input.is_action_just_released("ui_accept") and velocity.y < JUMP_RELEASE_FORCE:
#			velocity.y = JUMP_RELEASE_FORCE
#	fast_fall()
	move_and_slide()

func run_state(input):
	apply_gravity()
	print("Run state")
	if Input.is_action_just_pressed("ui_accept"):
		state = JUMP
	
func flying_state(input):
	apply_gravity()
	if Input.is_action_pressed("ui_up"):
		apply_thrust()
	else:
		state = FALL
	
func jump_state(input):
	apply_gravity()
	velocity.y = JUMP_VELOCITY
	if is_on_floor() and input.x == 0:
		state = IDLE
	elif is_on_floor() and input.x != 0:
		state = RUN
	
func idle_state(input):
	if input.x == 0:
		animation_player.play("Idle")
	elif Input.is_action_pressed("ui_up"):
		state = FLYING
	elif input.x != 0:
		state = RUN
	elif Input.is_action_just_pressed("ui_accept"):
		state = JUMP

func fall_state():
	animation_player.play("Fall")
	apply_gravity()
	if Input.is_action_pressed("ui_up"):
		state = FLYING
	if is_on_floor():
		state = IDLE

func apply_thrust():
	animation_player.play("Fly")
	velocity.y = lerp(0, MAX_THRUST, THRUST)

func fast_fall():
	if velocity.y > 0:
		animation_player.play("Fall")
		velocity.y += ADDITIONAL_FALL_GRAVITY

func apply_gravity():
	velocity.y += GRAVITY

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
