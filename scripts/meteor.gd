extends Area2D


var width
var hight 
var rng := RandomNumberGenerator.new()
var rand_theta : float
var rand_rotation_speed : float
var rand_speed : float 

func _ready() -> void:
	
	var path : String = "res://graphics/meteors/" + str(rng.randi_range(1,6)) + ".svg"
	$Sprite2D.texture = load(path)
	
	width = get_viewport().get_visible_rect().size.x
	hight = get_viewport().get_visible_rect().size.y

	# start position
	var rand_region : int = rng.randi_range(0,3)
	var rand_x
	var rand_y
	# 0 = up, 1 = bottom, 2 = left, 3 = right
	match  rand_region:
		0:
			rand_x = rng.randi_range(0, width)
			rand_y = rng.randi_range(-150,-50)
			rand_theta = (PI/6)*rng.randf_range(2.0,4.0)
		1:
			rand_x = rng.randi_range(0, width)
			rand_y = rng.randi_range(hight+150,hight+50)
			rand_theta = (PI/6)*rng.randf_range(8.0,10.0)
		2:
			rand_x = rng.randi_range(-150, -50)
			rand_y = rng.randi_range(0,hight)
			rand_theta = (PI/6)*rng.randf_range(11.0,13.0)
		3:
			rand_x = rng.randi_range(width+150, width+50)
			rand_y = rng.randi_range(0,hight)
			rand_theta = (PI/6)*rng.randf_range(5.0,7.0)
	
	position = Vector2(rand_x,rand_y)
	
	# start rotation speed
	rand_rotation_speed = rng.randf_range(-120,120)
	
	# start speed
	rand_speed = rng.randf_range(200,600)
	

func _process(delta: float) -> void:
	position += Vector2(cos(rand_theta), sin(rand_theta)) * rand_speed * delta
	rotation_degrees += rand_rotation_speed * delta
	
	if (global_position.y > hight+200) or (global_position.y < -200) or (global_position.x > width+200) or (global_position.x < -200) :
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	pass
