extends Node2D

@onready var projectile = preload("res://scenes/projectiles/projectile.tscn")
@onready var marker_2d = $Marker2D
var level
var can_shoot = true

func _ready():
	level = get_tree().get_first_node_in_group("Levels")

func _process(delta):
	look_at(get_global_mouse_position())



func _on_player_fire():
	if can_shoot:
		can_shoot = false
		var instance = projectile.instantiate()
		level.add_child(instance)
		instance.global_transform = marker_2d.global_transform
		var timer: Timer = Timer.new()
		add_child(timer)
		timer.wait_time = 0.2
		timer.one_shot = true
		timer.timeout.connect(func(): can_shoot = true)
		timer.start()
