extends Camera2D

export var speed: float = 10.0

func _ready():
	pass
	
func _process(delta):
	var inpx = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
	var inpy = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")))
	
	position.x = lerp(position.x, position.x + inpx * speed, speed * delta)
	position.y = lerp(position.y, position.y + inpy * speed, speed * delta)
