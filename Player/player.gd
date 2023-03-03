extends CharacterBody2D

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

@onready var animated_sprite := $AnimatedSprite2D
@onready var animation_player := $AnimationPlayer

enum state {
	RUN,
	JUMP,
	FALL,
	IDLE
}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	apply_gravity()
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if Input.is_action_pressed("ui_up"):
		
		apply_thrust()
		
	if input.x == 0:
		animated_sprite.play("Idle")
		apply_friction()
	else:
		animated_sprite.play("Run")
		
		apply_acceleration(input.x)
		
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_released("ui_accept") and velocity.y < JUMP_RELEASE_FORCE:
			velocity.y = JUMP_RELEASE_FORCE
	fast_fall()
	move_and_slide()

func apply_thrust():
#	animated_sprite.play("Fly")
	velocity.y = lerp(0, MAX_THRUST, THRUST)

func fast_fall():
	if velocity.y > 0:
#		animated_sprite.play("Fall")
		velocity.y += ADDITIONAL_FALL_GRAVITY

func apply_gravity():
	velocity.y += GRAVITY

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
	
func run_state():
	pass
	
func jump_state():
	pass
	
func fall_state():
	pass
	
func idle_state():
	pass
