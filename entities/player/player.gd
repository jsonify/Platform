extends CharacterBody2D

class_name Player

@onready var animation_player := $AnimationPlayer
@onready var animated_sprite := $AnimatedSprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -250.0
var sprite_frames
var is_jetpack_enabled

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = 500

func _ready():
#	Utils.saveGame()
	Utils.loadGame()
	animated_sprite.frames = load("res://entities/player/player_basic.tres")
	is_jetpack_enabled = Game.jetpack

func _physics_process(delta):
	# Add the jetpack
	is_jetpack_enabled = Game.jetpack
	print(is_jetpack_enabled)
	if is_jetpack_enabled:
		use_jetpack_powerup()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play("jump")
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	change_direction(direction)
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animation_player.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animation_player.play("idle")
	
	if velocity.y > 0:
		animation_player.play("fall")

	move_and_slide()
	
	if Game.playerHP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")

func change_direction(direction):
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false

func use_jetpack_powerup():
	animated_sprite.frames = load("res://entities/player/player_jetpack.tres")
	if Input.is_action_pressed("thrust"):
		animation_player.play("thrust")
