extends CharacterBody2D

# Set by parent scripts.
@export var horizontal_movement = 0
@export var just_pressed_jump = false
@export var pressing_jump = false

# Used by parent scripts.
@export var is_airborne = false # true, false

# The character experiences very slight acceleration and deceleration when starting
# and stopping to move horizontally.
const horizontal_acceleration = 1500
const horizontal_max_speed = 6500

# When the character leaves the ground, there is a tiny amount of delay before
# the character actually acts as though it has become airborne (for a short time,
# the character will not be affected by gravity and will still be able to jump.)
const airborne_delay = 0.05
var airborne_stopwatch = 0

# When the character jumps, they will move up at a constant speed until one
# of the following conditions occurs:
# 1. The character stops pressing the jump button AND the time spent jumping has
#    exceeded jump_min_hold.
# 2. The time spent jumping has exceeded jump_max_hold.
#
# The parameters are set so that a tap of the jump button allows the character to
# jump over 1-tile walls, while a maximum hold allows the character to jump over
# 2-tile walls.
const gravity_d = 25
const jump_initial_speed = 150
const jump_min_hold = 0.1
@export var jump_max_hold = 0.2 # NPCs will have a max of 0.3
var jump_stopwatch = 0
var jumping = false

var sprites
var npc_name : String

var alive = true
var world

var step_player
var jump_player
var rng = RandomNumberGenerator.new()

func _ready():
	world = get_tree().get_root().get_child(0)
	
	step_player = $StepPlayer
	jump_player = $JumpPlayer

func initialize_frames(character_name):
	sprites = $CharacterSprites
	npc_name = character_name
	sprites.animation = npc_name + "_idle"
	sprites.play()
#	$CharacterSprites.sprite_frames.add_animation(character_name + "_idle")
#	$CharacterSprites.sprite_frames.add_frame(
#		character_name + "_idle", load("res://art/characters/" + character_name + "/idle.png"))
#	$CharacterSprites.animation = character_name + "_idle"

func _physics_process(delta):
	if not alive: return
	
	# Horizontal movement
	var animation
	if horizontal_movement == -1:
		animation = npc_name + "_walk"
		velocity.x = max(-horizontal_max_speed * delta, velocity.x - horizontal_acceleration * delta)
	elif horizontal_movement == 1:
		animation = npc_name + "_walk"
		velocity.x = min(horizontal_max_speed * delta, velocity.x + horizontal_acceleration * delta)
	else:
		animation = npc_name + "_idle"
		velocity.x *= 0.25
	
	if is_airborne:
		if jumping:
			animation = npc_name + "_jump"
		else:
			animation = npc_name + "_fall"
			
	sprites.animation = animation
	
	# Face direction of movement
	if horizontal_movement == -1:
		$CharacterSprites.set_scale(Vector2(-2,2))
	elif horizontal_movement == 1:
		$CharacterSprites.set_scale(Vector2(2,2))

	
	# Airborne delay
	if is_on_floor():
		airborne_stopwatch = 0
	else:
		airborne_stopwatch += delta
	
	# Jumping
	if just_pressed_jump && airborne_stopwatch <= airborne_delay:
		play_sound(jump_player, 0.3)
		jump_stopwatch = 0
		jumping = true
		airborne_stopwatch += airborne_delay # Prevent double jump
		velocity.y = -jump_initial_speed
	if not pressing_jump and jump_stopwatch > jump_min_hold:
		jumping = false
	
	if jumping:
		jump_stopwatch += delta
	# Min jump hold reached (no longer pressing)
	if jump_stopwatch > jump_min_hold and jumping and not pressing_jump:
		jumping = false
	# Max jump hold reached (still pressing)
	if jump_stopwatch > jump_max_hold:
		jumping = false
	
	# Gravity
	if airborne_stopwatch > airborne_delay and not jumping:
		velocity.y += gravity_d
	
	# Collisions
	var is_on_boat = false
	
	move_and_slide()
	for i in get_slide_collision_count():
		
		var collision = get_slide_collision(i)
		var normal = collision.get_normal()
		var collider = collision.get_collider()
		var name = collider.name
		
		if collider.has_method("collide_player"):
			collider.collide_player()
		
		if collider.has_method("pushed_by_player") and abs(normal.x) > abs(normal.y):
			collider.pushed_by_player(normal.x < 0)
		
		if name == "Boat" and abs(normal.y) > abs(normal.x):
			is_on_boat = true
	
	set_collision_mask_value(4, not is_on_boat)
	
	# Exported variables	
	is_airborne = (airborne_stopwatch > airborne_delay)

func kill():
	alive = false
	print(npc_name + " died! rest in pepperoni ;-;")
	world._character_died(npc_name)

func _on_character_sprites_frame_changed():
	if (horizontal_movement == 0 or is_airborne): return
	
	match sprites.get_frame():
		0, 2:
			play_sound(step_player, 0.2)

func _on_character_sprites_animation_changed():
	if sprites.animation == npc_name + "_walk":
		play_sound(step_player, 0.2)

func play_sound(player, pitch_variation):
	player.pitch_scale = rng.randf_range(1 - pitch_variation, 1 + pitch_variation)
	player.play()
