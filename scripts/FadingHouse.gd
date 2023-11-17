extends Area2D

var player_inside

# Called when the node enters the scene tree for the first time.
func _ready():
	player_inside = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# can be set to fade later if we want / if we end up not fading move this to 
	# on_body_entered/exited for efficiency
	if player_inside:
		$BuildingExterior.set_modulate(Color(1, 1, 1, 0))
	else:
		$BuildingExterior.set_modulate(Color(1,1,1,1))

func _on_body_entered(body):
	if body.get_parent().name == "Player":
		print("in")
		player_inside = true

func _on_body_exited(body):
	if body.get_parent().name == "Player":
		print("out")
		player_inside = false

