extends Node2D

var tiles

# Called when the node enters the scene tree for the first time.
func _ready():
	tiles = get_children()
#	collapse_tiles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# Call this using an event from world
func collapse_tiles():
	for tile in tiles:
		if tile is PhysicsBody2D:
			tile.gravity_scale = 0.3
			tile.linear_velocity.x += 100
	#		tile.linear_velocity.y += 100

