extends Node2D

var runtime = 0
var prevRuntime = 0

func _physics_process(delta):
	prevRuntime = runtime
	runtime += delta
	
	$Ocean.position.y = -runtime * 1
