extends Area2D

@export var thisText = []
var curr_index = 0

var player_in_collision = false
var showing = false
var inAnimation = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D2.hide()
	$RichTextLabel.hide()
	player_in_collision = false
	showing = false
	inAnimation = false
	thisText = get_parent().thisText

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if player_in_collision && !showing:
			showing = true
			start_dialogue()
		elif curr_index == thisText.size() - 1 && !inAnimation:
			hideText()
		elif !inAnimation:
			curr_index += 1
			showText()

func _on_body_entered(body):
	player_in_collision = true

func _on_body_exited(body):
	player_in_collision = false

func start_dialogue():
	curr_index = 0
	showText()

func showText():
	await get_tree().create_timer(0.017).timeout
	inAnimation = true
	var curr_dialogue = thisText[curr_index]
	$Sprite2D2.show()
	$RichTextLabel.show()
	var temp = ""
	for char in curr_dialogue:
		if Input.is_action_just_pressed("interact"):
			$RichTextLabel.text = curr_dialogue
			break
		temp += char
		$RichTextLabel.text = temp
		await get_tree().create_timer(0.016).timeout
	inAnimation = false




func hideText():
	$RichTextLabel.text = ""
	showing = false
	$Sprite2D2.hide()
	$RichTextLabel.hide()
