extends CharacterBody2D

class_name Player

@onready var animation_player := $AnimationPlayer
@onready var animated_sprite := $AnimatedSprite2D

@export var JUMP_VELOCITY := -160.0
@export var JUMP_RELEASE_FORCE := -40
@export var MAX_SPEED := 75
@export var ACCELERATION := 10
@export var FRICTION := 10
@export var ADDITIONAL_FALL_GRAVITY := 2
@export var THRUST := -1
@export var MAX_THRUST := 50

enum states { RUN, JUMP, FALL, IDLE, THRUST }
var state = states.FALL

var sprite_frames
var jetpack_enabled
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction := "right"

func _ready():
#	Utils.saveGame()
	Utils.loadGame()
	animated_sprite.frames = load("res://entities/player/player_basic.tres")
	jetpack_enabled = Game.jetpack


func _physics_process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("thrust", "ui_down")

	match state:
		states.RUN:
			run_state(input, delta)
		states.JUMP:
			jump_state(input, delta)
		states.FALL:
			fall_state(input, delta)
		states.IDLE:
			idle_state(input)
		states.THRUST:
			thrust_state(input)

	if jetpack_enabled:
		use_jetpack_powerup()

	fast_fall()
	move_and_slide()
	die()


func apply_gravity():
	velocity.y += GRAVITY


func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
	
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)


func fast_fall():
	if velocity.y > 0:
		velocity.y += ADDITIONAL_FALL_GRAVITY


func jump_state(input, _delta):
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			animation_player.play("jump")
			velocity.y = JUMP_VELOCITY

	update_direction(input)
	apply_gravity()
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		apply_acceleration(input.x)
	if velocity.y < 0:
		state = states.FALL


func fall_state(input, _delta):
	apply_gravity()
	update_direction(input)
	animation_player.play("fall")
	if is_on_floor():
		state = states.IDLE
	elif Input.is_action_pressed("thrust") and jetpack_enabled:
		state = states.THRUST

	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		apply_acceleration(input.x)


func idle_state(_input):
	apply_friction()
	animation_player.play("idle")
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		state = states.RUN
	elif Input.is_action_pressed("jump"):
		state = states.JUMP
	elif Input.is_action_pressed("thrust") and jetpack_enabled:
		state = states.THRUST

	if velocity.y > 0:
		state = states.FALL
	
func thrust_state(input):
	if jetpack_enabled:
		animation_player.play("thrust")
		apply_thrust()
		update_direction(input)
		if Input.is_action_just_released("thrust"):
			state = states.FALL
		elif input.x != 0:
			apply_acceleration(input.x)

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

func run_state(input, _delta):
	update_direction(input)
	apply_gravity()

	if input.x == 0:
		state = states.IDLE
	else:
		animation_player.play("run")
		apply_acceleration(input.x)
	if not is_on_floor() and velocity.y > 0:
		state = states.FALL
	if Input.is_action_pressed("thrust") and jetpack_enabled:
		state = states.THRUST
	elif Input.is_action_pressed("jump"):
		state = states.JUMP
		
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
