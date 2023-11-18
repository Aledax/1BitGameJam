extends Control

var shader_material

# Called when the node enters the scene tree for the first time.
func _ready():
	# Shader
	shader_material = $ColorMaskNode/ColorMask.get_material()
	shader_material.set_shader_parameter("inverted", false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_game():
	get_tree().change_scene_to_file("res://scenes/pregame_text.tscn")
