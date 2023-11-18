extends Node2D

@export var apply_torque = 0
var tiles


# Called when the node enters the scene tree for the first time.
func _ready():
	tiles = get_children()
	collapse_tiles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# Call this using an event from world
func collapse_tiles():
	for tile in tiles:
		if tile is PhysicsBody2D:
#			await get_tree().create_timer(2).timeout
			tile.gravity_scale = 0.3
			tile.angular_velocity += apply_torque
			tile.linear_velocity.x += apply_torque / 5
			tile.linear_velocity.y -= 80

