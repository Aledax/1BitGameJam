extends Sprite2D

var currx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	currx = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currx += 20*delta
	position = position + Vector2(0, sin(currx/2))
