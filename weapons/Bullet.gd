extends Area2D
class_name Bullet

export var speed: int = 20 setget set_speed

var direction := Vector2.ZERO setget set_direction
var damage: int = 10 setget set_damage
var sprite_scale: float = 0.3 setget set_sprite_scale

onready var kill_timer = $KillTimer
onready var sprite = $Sprite

func _ready():
	kill_timer.start()
	sprite.scale.x = sprite_scale

func _physics_process(_delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		
		global_position += velocity

func set_direction(value: Vector2):
	direction = value
	rotation += value.angle()

func set_damage(value):
	damage = value

func set_speed(value):
	speed = value

func _on_KillTimer_timeout():
	queue_free()

func set_sprite_scale(value):
	sprite_scale = value

func _on_Bullet_body_entered(body: KinematicBody2D):
	if not body:
		queue_free()
		return
	if body.has_method("handle_hit"):
		body.handle_hit(damage)
		queue_free()
	else:
		print("did not found method take hit")
