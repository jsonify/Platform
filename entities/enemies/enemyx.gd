extends CharacterBody2D

@onready var sprite = $Sprite2D

@export var speed := 100
@export var chase_speed := 200
@export var detection_range := 200
#@export var detection_area_size := Vector2(200, 200)
@export var raycast_distance := 50

var player_chase := false
var player = null

func _process(delta):
	if player_chase:
		var direction = (player.position - position).normalized()
		var velocity = direction * chase_speed
		move_and_slide()
		if player.position.x < position.x:
			sprite.scale.x = -1
		else:
			sprite.scale.x = 1
	else:
		move_and_slide(Vector2(speed, 0), GRAVITY, Vector2(0, -1))

	var collision = move_and_collide(Vector2(speed, 0) * delta, false, false)
	if collision:
		if collision.collider.name == "RayCast2D":
			sprite.scale.x *= -1

func _on_detection_area_body_entered(body):
	if body is Player:
		player = body
		player_chase = true

func _on_detection_area_body_exited(body):
	if body is Player:
		player = null
		player_chase = false

func _physics_process(delta):
	if player and abs(player.position.x - position.x) > detection_range:
		player_chase = false

	var ray_start = position + Vector2(sprite.scale.x * sprite.texture.width / 2, 0)
	var ray_end = ray_start + Vector2(sprite.scale.x * raycast_distance, 0)
	raycast.cast_to = Vector2(sprite.scale.x * raycast_distance, 0)
	raycast.force_raycast_update()
	if not raycast.is_colliding():
		sprite.scale.x *= -1

func _ready():
	detection_area.shape = Rect2(-detection_area_size / 2, detection_area_size)
	detection_area.set_as_trigger(true)
