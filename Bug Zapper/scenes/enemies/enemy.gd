extends CharacterBody2D

class_name Enemy

@export var health:float = 100.0
@export var speed:float = 200.0
var target:Node
@export var attackTimer: float = 0.5
@export var dmg:float = 15
var attacking:bool = false
var playerInArea = false


func _physics_process(delta) -> void:
	if target == null:
		target = get_tree().get_first_node_in_group("Player")
	if target != null && !attacking: #only move when not attacking
		velocity = global_position.direction_to(target.global_position) * speed
		move_and_slide()
		look_at(target.global_position)
	if target != null && playerInArea && !attacking: #Only start attack if player in area and not already attacking
		attacking = true
		await get_tree().create_timer(attackTimer).timeout
		if playerInArea: #only damage player if player is still in area!
			target.hit(dmg)
		attacking = false


func hit(dmg:float) -> void:
	health = clamp(health - dmg, 0, 100)
	if health == 0:
		queue_free()


func _on_attack_area_body_entered(body) -> void:
	playerInArea = true
		


func _on_attack_area_body_exited(body) -> void:
	attacking = false
	playerInArea = false
