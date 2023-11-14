extends Node2D

var speed = 10

func _ready():
	var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

func _process(delta):
	$LeftWaves.region_rect.position.x += speed * delta
	$RightWaves.region_rect.position.x -= speed * delta
