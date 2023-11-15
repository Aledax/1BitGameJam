extends Node2D

var speed = 10

func _process(delta):
	$LeftWaves.region_rect.position.x += speed * delta
	$RightWaves.region_rect.position.x -= speed * delta
