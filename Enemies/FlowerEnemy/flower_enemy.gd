extends CharacterBody2D

@onready var ledge_check_right = $LedgeCheckRight
@onready var ledge_check_left = $LedgeCheckLeft
@onready var timer := $Timer
@onready var animated_sprite = $AnimatedSprite2D
@onready var stats := $Stats

var speed := 10
var direction = 1

var knockback := Vector2.ZERO

func _ready():
	if direction == 1:
		animated_sprite.flip_h = false


func _physics_process(delta):
	animated_sprite.play("move")
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	handle_wall()
	handle_ledge()
	move_and_slide()


func handle_ledge():
	var found_ledge = not ledge_check_right.is_colliding() or not ledge_check_left.is_colliding()
	if found_ledge:
		direction *= -1
		animated_sprite.flip_h = not animated_sprite.flip_h
	velocity.x = direction * speed


func handle_wall():
	if is_on_wall():
		direction *= -1
		animated_sprite.flip_h = not animated_sprite.flip_h
	velocity.x = direction * speed


func _on_hurtbox_area_entered(area):
	if area.is_instance_of(BulletHitbox):
		stats.health -= area.damage
# Finish this someday
#		knockback = area.knockback_vector * 120


func _on_timer_timeout():
	queue_free()


func _on_stats_no_health():
		timer.start()
		speed = 0
