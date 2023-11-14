extends Sprite2D

@export var fall_speed = 1000

func _process(delta):
	region_rect.position.y -= fall_speed * delta
