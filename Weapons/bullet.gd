extends Area2D

class_name Bullet

var direction := Vector2.RIGHT
var speed := 200

func _ready():
	look_at(position + direction)

func _process(delta):
	translate(direction.normalized() * speed * delta)
	

# TODO: add timer to remove bullets

func _on_body_entered(body):
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



func _on_timer_timeout():
	queue_free()
