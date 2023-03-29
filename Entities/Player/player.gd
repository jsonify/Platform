extends "res://Entities/entity_base.gd"
class_name Player


@export var JUMP_VELOCITY := -160.0
@export var JUMP_RELEASE_FORCE := -40
@export var MAX_SPEED := 75
@export var ACCELERATION := 10
@export var FRICTION := 10
@export var ADDITIONAL_FALL_GRAVITY := 2
@export var THRUST := -1
@export var MAX_THRUST := 50

@onready var state_label := $StateLabel
@onready var remoteTransform2D := $RemoteTransform2D

@export var jetpack_enabled = false

signal health_changed(amount)

enum states { RUN, JUMP, FALL, IDLE, THRUST }

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_knockback = Vector2.ZERO

@export var debug_enabled_status := false
var state = states.FALL
var direction := "right"
var health


func _ready():
	SPEED = 100
	SaveLoad.load_data()
	jetpack_enabled = SaveLoad.data["player"]["jetpack_enabled"]
	health = SaveLoad.data["player"]["max_health"]
	

func player_die_2():
	queue_free()

func _process(_delta):
	debug_enabled(debug_enabled_status)


func _physics_process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("thrust", "ui_down")
	
	
	if jetpack_enabled:
		sprite.texture = load("res://Assets/Player/hero_JETPACK_24x36.png")

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

	fast_fall()
	move_and_slide()


func apply_thrust():
	animation_player.play("Thrust")
	velocity.y = lerp(0, MAX_THRUST, THRUST)


func fast_fall():
	if velocity.y > 0:
		velocity.y += ADDITIONAL_FALL_GRAVITY


func apply_gravity():
	velocity.y += GRAVITY


func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)


func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)


func run_state(input, _delta):
	update_direction(input)
	apply_gravity()

	if input.x == 0:
		state = states.IDLE
	else:
		animation_player.play("Run")
		apply_acceleration(input.x)
	if not is_on_floor() and velocity.y > 0:
		state = states.FALL
	if Input.is_action_pressed("thrust") and jetpack_enabled:
		state = states.THRUST
	elif Input.is_action_pressed("jump"):
		state = states.JUMP


func jump_state(input, _delta):
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			animation_player.play("Jump")
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
	animation_player.play("Fall")
	if is_on_floor():
		state = states.IDLE
	elif Input.is_action_pressed("thrust") and jetpack_enabled:
		state = states.THRUST

	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		apply_acceleration(input.x)


func idle_state(_input):
	apply_friction()
	animation_player.play("Idle")
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
		animation_player.play("Thrust")
		apply_thrust()
		update_direction(input)
		if Input.is_action_just_released("thrust"):
			state = states.FALL
		elif input.x != 0:
			apply_acceleration(input.x)

func apply_small_gravity():
	velocity.y -= 50

func knockback(enemy_pos_x):
	$Timer.start()
	set_modulate(Color(1,0.3,0.3,0.3))
#	state = states.FALL
	if position.x >= enemy_pos_x:
		velocity.x = -200
		print(enemy_pos_x)
#	Why doesn't this doesn't work??
	elif position.x <= enemy_pos_x:
		velocity.x = 200
		print(enemy_pos_x)

func player_die():
	queue_free()
	Events.emit_signal("player_died")


func connect_camera(camera):
	var camera_path = camera.get_path()
	remoteTransform2D.remote_path = camera_path


func update_direction(input) -> void:
	if input.x > 0:
		set_direction_right()
	elif input.x < 0:
		set_direction_left()


func debug_enabled(status):
	debug_enabled_status = status
	if debug_enabled_status == true:
		state_label.text = states.keys()[state] + "\n\n " + str(health)


func set_direction_right() -> void:
	direction = "right"
	sprite.flip_h = false


func set_direction_left() -> void:
	direction = "left"
	sprite.flip_h = true
#	$HitboxPosition.rotation_degrees = 180

func take_damage(amount:int):
	health -= amount
	pass

func _on_timer_timeout():
	set_modulate(Color(1,1,1,1))
