extends Node2D

@export var apply_torque = 0
@export var has_collision : bool = false
var tiles

func _ready():
	tiles = get_children()

func _collapse_event(name):
	if name != self.name: return
	
	$AudioPlayer.play()
	for tile in tiles:
		if tile is PhysicsBody2D:
#			await get_tree().create_timer(2).timeout
			tile.gravity_scale = 0.3
			tile.angular_velocity += apply_torque * randf_range(-1, 1)
			tile.linear_velocity.x += apply_torque * randf_range(-1, 1)
			tile.linear_velocity.y -= 80
			tile.set_collision_layer_value(1, has_collision)
