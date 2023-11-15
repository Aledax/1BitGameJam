extends Node2D

@export var npc_name = "npctest"
@export var texts: Dictionary

var character_body
var text_interactible

var target_x
var just_jumped_timer = 0
var jump_timer = 0

func _ready():
	character_body = $CharacterBody
	character_body.initialize_frames(npc_name)
	text_interactible = $CharacterBody/textInteractible
	text_interactible.set_texts(texts)

func _physics_process(delta):
	if (character_body.horizontal_movement == -1 and character_body.global_position.x <= target_x) or (character_body.horizontal_movement == 1 and character_body.global_position.x >= target_x):
		character_body.horizontal_movement = 0
	
	jump_timer = max(0, jump_timer - delta)
	if jump_timer == 0:
		character_body.pressing_jump = false
	
	just_jumped_timer = max(0, just_jumped_timer - 1)
	if just_jumped_timer == 0:
		character_body.just_pressed_jump = false

func _npc_move_event(npc_name, target_x):
	if get_parent().name != npc_name: return
	
	self.target_x = target_x
	if target_x < character_body.global_position.x:
		character_body.horizontal_movement = -1
	elif target_x > character_body.global_position.x:
		character_body.horizontal_movement = 1

func _npc_jump_event(npc_name, hold_time):
	if get_parent().name != npc_name: return
	
	character_body.just_pressed_jump = true
	character_body.pressing_jump = true
	just_jumped_timer = 2
	jump_timer = hold_time

func _npc_switch_dialogue_event(npc_name, dialogue_key):
	if get_parent().name != npc_name: return
	
	text_interactible.set_dialogue(dialogue_key)
