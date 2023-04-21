extends CharacterBody2D

var SPEED := 20
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase := false


@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("idle")
	gravity += 200

func _physics_process(delta):
	# Gravity for flower
	velocity.y += gravity * delta
	player = get_node("../../Player/player")
	var direction = (player.position - self.position).normalized()
	var player_on_left = player.position.x < self.position.x

	if chase == true:
		if animated_sprite.animation != "death":
			animated_sprite.play("move")

		if player_on_left:
			get_node("AnimatedSprite2D").flip_h = true
			direction.x = -abs(direction.x)  # flip the x direction to move left
			print(direction.x)
		else:
			get_node("AnimatedSprite2D").flip_h = false
			direction.x = abs(direction.x)  # keep the x direction positive to move right
			print(direction.x)

		velocity = direction * SPEED
		
	else: 
		if animated_sprite.animation != "death":
			animated_sprite.play("idle")
		velocity.x = 0
		
	move_and_slide()
	
	
func _on_player_detection_body_entered(body):
	if body is Player:
		chase = true
		print("chase: " + str(chase))


func _on_player_detection_body_exited(body):
	if body.name == "player":
		chase = false


func _on_player_death_body_entered(body):
	if body.name == "player":
		death()


func _on_player_collision_body_entered(body):
	if body.name == "player":
		Game.playerHP -= 3


func death():
	Game.gold += 5
	Utils.saveGame()
	chase = false
	animated_sprite.play("death")
	await animated_sprite.animation_finished
	queue_free()
