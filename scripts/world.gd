extends Node2D

const rise_delay = 5
const rise_speed = 5

var runtime = 0
var prevRuntime = 0

func _physics_process(delta):
	prevRuntime = runtime
	runtime += delta
	
	$Ocean.position.y = -max(runtime - rise_delay, 0) * rise_speed
