extends Control

@export var text = ""

var done = false

# Called when the node enters the scene tree for the first time.
func _ready():
	text = $Label.text
	$E.hide()
	showText()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") && done:
		get_tree().change_scene_to_file("res://scenes/world.tscn")

func showText():
	var temp = ""
	for char in text:
		if Input.is_action_just_pressed("interact"):
			$Label.text = text
			break
		temp += char
		$Label.text = temp
		await get_tree().create_timer(0.05).timeout
	done = true
	$E.show()
