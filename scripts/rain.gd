extends Sprite2D

@export var fall_speed = 1800

func _process(delta):
	region_rect.position.y -= fall_speed * delta
