extends Node2D

signal shoot
signal look(position)
signal state_changed(new_state)

export var watch_group: String = "player_units"
onready var detection_range = $Range


var enemies_on_range = {}
var active_target: KinematicBody2D = null

enum State {
	PATROL,
	ENGAGE
}

var current_state: int = State.PATROL setget set_state

func set_state(new_state: int):
	if new_state == current_state:
		return
	current_state = new_state
	emit_signal("state_changed", current_state)

func _on_Range_body_entered(body):
	if body.is_in_group(watch_group):
		enemies_on_range[body.get_instance_id()] = body


func _on_Range_body_exited(body):
	if body.is_in_group(watch_group):
		print("player Exited view area", body)
		enemies_on_range.erase(body.get_instance_id())

func _physics_process(_delta):
	if enemies_on_range.size() > 0:
		var active_key = enemies_on_range.keys()[0]
		active_target = enemies_on_range[active_key]
	else:
		active_target = null
	if active_target:
		emit_signal("look", active_target.position)
		emit_signal("shoot")
		
