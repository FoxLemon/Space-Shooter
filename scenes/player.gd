extends CharacterBody2D

@export var speed : float = 250
@export var rotation_speed : float = 120
@export var recoil : float = 1

signal laser(pos, rot: float)

func shoot() -> void:
	var derction = Vector2(cos(rotation),sin(rotation))
	laser.emit($LaserStartPosition.global_position, rotation_degrees)
	velocity += derction * recoil	

func _on_shoot_rate_timeout() -> void:
	shoot()

func shoot_laser() -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()
		$ShootRate.start()
	elif Input.is_action_just_released("shoot"):
		$ShootRate.stop()

func accelerate(delta) -> void:
	# Negative because sprite is pointed to the left
	var derction = -Vector2(cos(rotation),sin(rotation))
	velocity += derction * speed * delta

func slow_stop(delta) -> void:
	velocity -= velocity.normalized() * (speed*1.5) * delta

func player_movement(delta) -> void:
	if Input.is_action_pressed("forward"):
		$IonFlame.visible = true
		accelerate(delta)
	
	if Input.is_action_just_released("forward"):
		$IonFlame.visible = false
		
	if Input.is_action_pressed("backward"):
		slow_stop(delta)
		
	if Input.is_action_pressed("rotate_left"):
		rotation_degrees -= rotation_speed * delta
		
	if Input.is_action_pressed("rotate_right"):
		rotation_degrees += rotation_speed * delta
		
	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$IonFlame.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_movement(delta)
	
	# shoot laser
	shoot_laser()
	
