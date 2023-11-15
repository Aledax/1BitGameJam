extends Area2D

@export var texts = {"":[]}
var curr_index = 0
var dialogue_key = ""

var player_in_collision = false
var showing = false
var inAnimation = false

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue_key = "default"
	$Sprite2D2.hide()
	$RichTextLabel.hide()
	player_in_collision = false
	showing = false
	inAnimation = false
	texts = get_parent().texts
	
func set_dialogue(dialogue_key):
	if texts.has(dialogue_key):
		self.dialogue_key = dialogue_key
	else:
		self.dialogue_key = "default"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if player_in_collision && !showing:
			showing = true
			start_dialogue()
		elif showing:
			print(curr_index)
			print(texts[dialogue_key].size() - 1)
			if curr_index >= texts[dialogue_key].size() - 1:
				hideText()
			elif !inAnimation:
				curr_index += 1
				showText()

func _on_body_entered(body):
	if body.get_parent().name == "Player":
		player_in_collision = true

func _on_body_exited(body):
	if body.get_parent().name == "Player":
		player_in_collision = false

func start_dialogue():
	get_tree().paused = true
	curr_index = 0
	showText()

func showText():
	await get_tree().create_timer(0.017).timeout
	inAnimation = true
	var curr_dialogue = texts[dialogue_key][curr_index]
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
	get_tree().paused = false
