extends Area2D

@export var char_name = ""

var desired_item : Node2D

var texts = {"":[[""]]}
var text_index = 0
var curr_index = 0
var dialogue_key = ""

var player_in_collision = false
var interacting = false
var inAnimation = false

var interact_symbol
var player_node : Node2D

func _ready():
	print(char_name)
	dialogue_key = "default"
	$Sprite2D2.hide()
	$RichTextLabel.hide()
	player_in_collision = false
	interacting = false
	inAnimation = false
	interact_symbol = $InteractSymbol
	interact_symbol.hide()
	
func set_texts(given_texts):
	texts = given_texts

func set_npc_name(given_name):
	char_name = given_name
	print(char_name)

func set_dialogue(dialogue_key):
	if texts.has(dialogue_key):
		self.dialogue_key = dialogue_key
		text_index = 0
	else:
		print("text interactible does not contain key: " + dialogue_key)
		self.dialogue_key = "default"

func set_desired_item(desired_item):
	self.desired_item = desired_item

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if interacting && !inAnimation:
			if curr_index >= texts[dialogue_key][text_index].size() - 1: # end of one conversation, switch to next conversation
				hideText()
				text_index = (text_index + 1) % texts[dialogue_key].size()
			else:
				nextText()
		elif player_in_collision && !interacting:
			interacting = true
			start_dialogue()

func _on_body_entered(body):
	if body.get_parent().name == "Player":
		player_node = body.get_parent()
		player_in_collision = true
		interact_symbol.show()
		print(get_tree().get_root().get_child(0))

func _on_body_exited(body):
	if body.get_parent().name == "Player":
		player_in_collision = false
		interact_symbol.hide()

func start_dialogue():
	if desired_item != null:
		if desired_item.npc_affected_name == char_name && desired_item in player_node.current_items:
				item_given()
	get_tree().paused = true
	curr_index = 0
	showText()

func showText():
	await get_tree().create_timer(0.017).timeout
	inAnimation = true
	var curr_dialogue = texts[dialogue_key][text_index][curr_index]
	$Sprite2D2.show()
	$RichTextLabel.show()
	var temp = ""
	for char in curr_dialogue:
		if Input.is_action_just_pressed("interact"):
			$RichTextLabel.text = curr_dialogue
			await get_tree().create_timer(0.017).timeout
			break
		temp += char
		$RichTextLabel.text = temp
		await get_tree().create_timer(0.016).timeout
	inAnimation = false

func item_given():
	player_node.delete_item(desired_item)
	set_dialogue(desired_item.npc_affected_dialogue_key)
	var world = get_tree().get_root().get_child(0)
	world.save(char_name)

func nextText():
	curr_index += 1
	showText()


func hideText():
	$RichTextLabel.text = ""
	interacting = false
	$Sprite2D2.hide()
	$RichTextLabel.hide()
	get_tree().paused = false
