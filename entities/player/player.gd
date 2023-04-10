extends CharacterBody2D

class_name Player

@onready var animation_player := $AnimationPlayer
@onready var animated_sprite := $AnimatedSprite2D

# @export var JUMP_VELOCITY := -160.0
@export var MAX_SPEED := 75
@export var ACCELERATION := 10
@export var FRICTION := 10
@export var ADDITIONAL_FALL_GRAVITY := 2
@export var THRUST := -1
@export var MAX_THRUST := 50

var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity")

# player movement
@export var SPEED = 70.0
@export var JUMP_VELOCITY = -300.0
var last_direction := Vector2.RIGHT

# mechanics
var can_dash = true
var can_thrust = false

# player input
var movement_input := Vector2.ZERO
var jump_input := false
var jump_input_actuation := false
var climb_input := false
var dash_input := false
var thrust_input := false

# states
var current_state = null
var prev_state = null

# nodes
@onready var STATES = $STATES
@onready var Raycasts = $Raycasts

# enum states { RUN, JUMP, FALL, IDLE, THRUST }
# var state = states.FALL

var sprite_frames
var jetpack_enabled

var direction := "right"
var fuel_level

func _ready():
#	Utils.saveGame()
	Utils.loadGame()
	animated_sprite.frames = load("res://entities/player/player_basic.tres")
	jetpack_enabled = Game.jetpack

	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	prev_state = STATES.IDLE
	current_state = STATES.IDLE


func _physics_process(delta):
	player_input()
	change_state(current_state.update(delta))
	$Label.text = str(current_state.get_name())

	fuel_level = Game.fuel_level
	if jetpack_enabled:
		use_jetpack_powerup()
		can_thrust = true

	# fast_fall()
	move_and_slide()
	die()
	
func gravity(delta):
	if not is_on_floor():
		velocity.y += gravity_value * delta

func change_state(input_state):
	if input_state != null:
		prev_state = current_state
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
	
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)


# func fast_fall():
# 	if velocity.y > 0:
# 		velocity.y += ADDITIONAL_FALL_GRAVITY


func player_input():
	movement_input = Vector2.ZERO
	if Input.is_action_pressed("right"):
		movement_input.x += 1
		change_direction(movement_input.x)
	if Input.is_action_pressed("left"):
		movement_input.x -= 1
		change_direction(movement_input.x)
		
	if Input.is_action_pressed("up"):
		movement_input.y -= 1
	if Input.is_action_pressed("down"):
		movement_input.x += 1
		
	# jumps
	if Input.is_action_pressed("jump"):
		jump_input = true
	else: 
		jump_input = false
	if Input.is_action_just_pressed("jump"):
		jump_input_actuation = true	
	else: 
		jump_input_actuation = false
	
	# CLIMB
	if Input.is_action_pressed("climb"):
		climb_input = true
	else:
		climb_input = false
	
	# DASH
	if Input.is_action_just_pressed("dash"):
		dash_input = true
	else:
		dash_input = false
		
	# SLIDE
	if Input.is_action_pressed("slide"):
		climb_input = true
	else:
		climb_input = false
		
	# THRUST
	if Input.is_action_pressed("thrust"):
		thrust_input = true
	else:
		thrust_input = false

func change_direction(direction):
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false

func use_jetpack_powerup():
	animated_sprite.frames = load("res://entities/player/player_jetpack.tres")
		
func apply_thrust():
	animation_player.play("thrust")
	velocity.y = lerp(0, MAX_THRUST, THRUST)
	
		
func update_direction(input) -> void:
	if input.x > 0:
		set_direction_right()
	elif input.x < 0:
		set_direction_left()
		

func set_direction_right() -> void:
	direction = "right"
	animated_sprite.flip_h = false


func set_direction_left() -> void:
	direction = "left"
	animated_sprite.flip_h = true

	
func die():
	if Game.playerHP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")


func get_next_to_wall():
	for raycast in Raycasts.get_children():
		raycast.force_raycast_update()
		if raycast.is_colliding():
			if raycast.target_position.x > 0:
				return Vector2.RIGHT
				print("colliding right")
			else:
				return Vector2.LEFT
				print("colliding left")
				
	return null


func _on_dialogue_player_set_player_active(active):
	set_physics_process(active)
	set_process(active)
	set_process_input(active)
