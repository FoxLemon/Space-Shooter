extends Node2D

var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size := get_viewport().get_visible_rect().size
	var rand_x : int
	var rand_y : int
	var rand_scale : float
	var rand_rot : float 
	var rand_play_speed : float

	# random position
	rand_x = rng.randi_range(0,int(screen_size.x))
	rand_y = rng.randi_range(0,int(screen_size.y))
	
	position = Vector2(rand_x,rand_y)
	
	# random scale 
	rand_scale = rng.randf_range(0.5,2)
	
	scale = Vector2(rand_scale,rand_scale)
	
	# random rotation
	rand_rot = 2*PI*rng.randf_range(0,20)
	
	rotation = rand_rot
	
	# random play speed
	rand_play_speed = rng.randf_range(0.6,1.4)
	
	$AnimatedSprite2D.speed_scale = rand_play_speed
