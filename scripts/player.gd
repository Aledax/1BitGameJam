extends Node2D

var character_body

func _ready():
	character_body = $CharacterBody
	character_body.initialize_frames("player")

func _physics_process(_delta):
	
	# Horizontal input
	var horizontal_movement = 0
	if Input.is_action_pressed("move_left"):
		horizontal_movement -= 1
	if Input.is_action_pressed("move_right"):
		horizontal_movement += 1
	character_body.horizontal_movement = horizontal_movement
	
	# Vertical input
	character_body.just_pressed_jump = Input.is_action_just_pressed("jump")
	character_body.pressing_jump = Input.is_action_pressed("jump")
