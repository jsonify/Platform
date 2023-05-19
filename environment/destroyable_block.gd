extends Area2D

@onready var fall_timer := $"../FallTimer"
@onready var destroy_timer := $"../DestroyTimer"
@onready var block := $"../Block"


func _on_timer_timeout():
	block.gravity_scale = 1
	print("should destroy")


func _on_body_entered(body):
	if body is Player:
		fall_timer.start()
		destroy_timer.start(2)


func _on_destroy_timer_timeout():
	get_parent().queue_free()
