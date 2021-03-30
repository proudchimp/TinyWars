extends Area2D

export var DEBUG_DRAW: bool = true

var range_size: int = 100 setget set_range_size

onready var range_collision: CollisionShape2D = $CollisionShape2D

func _ready():
	yield(get_tree(), "idle_frame")
	set_range_size(range_size)
	

func set_range_size(value: int):
	range_size = value
	var shape = CircleShape2D.new()
	shape.radius = range_size
	range_collision.set_shape(shape)


func _draw():
	if !DEBUG_DRAW:
		return
	draw_circle(Vector2.ZERO, range_collision.shape.radius,
				Color(0, 1, 1, 0.2))
