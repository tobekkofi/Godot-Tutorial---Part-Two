extends Area2D

class_name Projectile

@export var damage: float = 25.0
@export var speed: float = 25.0

func _physics_process(delta):
	position += transform.x * speed


func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body.has_method("hit"):
		body.hit(damage)
		queue_free()
