extends KinematicBody2D
class_name PlayerSoldier

signal player_fired(bullet, place, direction)

export var DEBUG_DRAW: bool = false
export (PackedScene) var Bullet

export var speed: float = 100
export var avoid_weight: float = 0.2
export var initial_health: int = 100
export var range_size: int = 200
export var gun_cooldown: float = 0.2
export var watch_group = "enemy_units"
export var initial_damage = 10

var target = null setget set_target
var selected = false setget set_selected
var enemies_on_range = {}
var active_target: KinematicBody2D = null
var av := Vector2.ZERO
var target_radius = 15
var velocity := Vector2.ZERO

onready var avoidArea: Area2D = $AvoidArea
onready var sprite: Sprite = $Sprite
onready var gun = $GunHandler/Gun
onready var gun_direction = $GunHandler/GunDirection
onready var attack_cooldown = $GunHandler/AttackCooldown
onready var gun_handler = $GunHandler
onready var unit_range = $Range
onready var health = $Health

func _ready():
	yield(get_tree(), "idle_frame")
	sprite.material = sprite.material.duplicate()
	unit_range.set_range_size(range_size)
	gun_handler.set_cooldown(gun_cooldown)
	health.set_health(initial_health)
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	# move to target	
	if target:
		velocity = position.direction_to(target)
		if position.distance_to(target) < target_radius:
			target = null
	
	#avoid own units
	av = avoid()
	velocity = (velocity + av * avoid_weight).normalized()
	
	# rotates to target
	if velocity.length() > 0:
		rotation = velocity.angle()
	
	var _collision = move_and_collide(velocity * speed * delta)
	update()
	
	if enemies_on_range.size() > 0:
		var active_key = enemies_on_range.keys()[0]
		active_target = enemies_on_range[active_key]
	else:
		active_target = null
			
	if active_target:
		look_at(active_target.position)
		shoot()

func shoot():
	if attack_cooldown.is_stopped():
		var bullet_instance = Bullet.instance()
		var new_damage = initial_damage * (health.health/initial_health)
		bullet_instance.set_damage(new_damage)
		var bullet_direction = gun_direction.global_position - gun.global_position
		emit_signal("player_fired", bullet_instance, gun.global_position, bullet_direction.normalized())
		attack_cooldown.start()

func set_target(value):
	target = value
	
func set_selected(value):
	selected = value
	if selected:
		sprite.material.set_shader_param("aura_width", 1)
	else:
		sprite.material.set_shader_param("aura_width", 0)

func avoid():
	var result = Vector2.ZERO
	var neighboors = avoidArea.get_overlapping_bodies()
	if !neighboors:
		return result
	for n in neighboors:
		result += n.position.direction_to(position)
	result /= neighboors.size()
	return result.normalized()

func handle_hit(damage: int):
	return health.take_hit(damage)
	
	

func _on_Range_body_entered(body: KinematicBody2D):
	if body.is_in_group(watch_group):
		print("Enemy Entered View", body)
		enemies_on_range[body.get_instance_id()] = body

func _on_Range_body_exited(body):	
	if body.is_in_group(watch_group):
		print("Enemy Exited view area", body)
		enemies_on_range.erase(body.get_instance_id())

func _on_Health_dead():
	queue_free()

func _draw():
	# Draws some debug vectors.
	if DEBUG_DRAW:
		draw_circle(Vector2.ZERO, $AvoidArea/CollisionShape2D.shape.radius,
					Color(1, 1, 0, 0.2))
		draw_line(Vector2.ZERO, av.rotated(-rotation)*50, Color(1, 0, 0), 5)
		draw_line(Vector2.ZERO, velocity.rotated(-rotation)*speed, Color(0, 1, 0), 5)
		if target:
			draw_line(Vector2.ZERO, position.direction_to(target).rotated(-rotation)*50,
				Color(0, 0, 1), 5)



