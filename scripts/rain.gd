extends Sprite2D

@export var fall_speed = 1800

func _ready():
	var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")
	var screen_size = Vector2(screen_width, screen_height)
	position = screen_size / 2
	region_rect.size = screen_size * 1.5

func _process(delta):
	region_rect.position.y -= fall_speed * delta
