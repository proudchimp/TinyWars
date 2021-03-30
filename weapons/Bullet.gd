extends Area2D
class_name Bullet

export var speed: int = 20
export var damage: int = 10
export var group_owner: String

var direction := Vector2.ZERO setget set_direction

onready var kill_timer = $KillTimer

func _ready():
	kill_timer.start()

func _physics_process(_delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		
		global_position += velocity

func set_direction(value: Vector2):
	direction = value
	rotation += value.angle()


func _on_KillTimer_timeout():
	queue_free()


func _on_Bullet_body_entered(body: KinematicBody2D):
	if body.has_method("handle_hit"):
		body.handle_hit(damage)
		queue_free()
	else:
		print("did not found method take hit")
