extends CharacterBody2D

@export var speed: int = 700
@export var acceleration: float = 0.1
@export var deceleration: float = 0.5
@export var health: float = 100.0

signal fire

func _physics_process(delta):
	#Get direction from input
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	
	#If direction is getting input, multiply built in velocity with the direction and a speed
	if direction:
		velocity = velocity.lerp(direction * speed, acceleration)
	#If there's nothing in direction, stop moving
	else:
		velocity = velocity.lerp(direction * speed, deceleration)
	#Call the built in move and slide function
	move_and_slide()
	
	if Input.is_action_pressed("shoot"):
		emit_signal("fire")
		
func hit(dmg:float) -> void:
	health = clamp(health - dmg, 0, 100)
	print(health)
