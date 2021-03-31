extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var amplitude: int = 0
onready var camera = get_parent()
onready var tween: Tween = $ShakeTween
onready var timer_frequency: Timer = $Frequency
onready var timer_duration: Timer = $Duration

func start(duration=0.2, frequency=15, amplitude=4):
	self.amplitude = amplitude
	timer_duration.wait_time = duration
	timer_frequency.wait_time = 1/float(frequency)
	timer_duration.start()
	timer_frequency.start()
	
	_new_shake()

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	
	tween.interpolate_property(camera, "offset", camera.offset, rand, timer_frequency.wait_time, TRANS, EASE)
	tween.start()
	
func _reset():
	tween.interpolate_property(camera, "offset", camera.offset, Vector2.ZERO, timer_frequency.wait_time, TRANS, EASE)
	tween.start()

func _on_Frequency_timeout():
	_new_shake()


func _on_Duration_timeout():
	_reset()
	timer_frequency.stop()
