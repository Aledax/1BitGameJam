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
const jump_max_hold = 0.2
var jump_stopwatch = 0
var jumping = false

func initialize_frames(character_name):
	print(character_name)
	$CharacterSprites.sprite_frames.add_animation(character_name + "_idle")
	$CharacterSprites.sprite_frames.add_frame(
		character_name + "_idle", load("res://art/characters/" + character_name + "/idle.png"))
	$CharacterSprites.animation = character_name + "_idle"

func _physics_process(delta):
	
	# Horizontal movement
	if horizontal_movement == -1:
		velocity.x = max(-horizontal_max_speed * delta, velocity.x - horizontal_acceleration * delta)
	elif horizontal_movement == 1:
		velocity.x = min(horizontal_max_speed * delta, velocity.x + horizontal_acceleration * delta)
	else:
		velocity.x *= 0.25
	
	# Airborne delay
	if is_on_floor():
		airborne_stopwatch = 0
	else:
		airborne_stopwatch += delta
	
	# Jumping
	if just_pressed_jump && airborne_stopwatch <= airborne_delay:
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
	move_and_slide()
	for i in get_slide_collision_count():
		
		var collision = get_slide_collision(i)
		
		if collision.get_collider().has_method("collide_player"):
			collision.get_collider().collide_player()
		
		if collision.get_collider().has_method("pushed_by_player"):
			collision.get_collider().pushed_by_player(-collision.get_normal() * 50)
	
	# Exported variables
	if velocity.x < 0:
		horizontal_movement = -1
	elif velocity.x > 0:
		horizontal_movement = 1
	else:
		horizontal_movement = 0
	
	is_airborne = (airborne_stopwatch > airborne_delay)

