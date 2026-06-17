extends Area2D

@export var speed : int = 1200

var size : Vector2

func _ready() -> void:
	size = get_viewport().get_visible_rect().size
	
	$Sprite2D.scale = Vector2(0,0)
	var tween := create_tween()
	tween.tween_property($Sprite2D,"scale",Vector2(3,3),0.1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position -= Vector2(cos(rotation),sin(rotation)) * speed * delta
	
	if (global_position.y > size.y) or (global_position.y < 0) or (global_position.x > size.x) or (global_position.x < 0) :
		queue_free()
