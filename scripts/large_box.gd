extends RigidBody2D

const player_impulse_factor = 8 # EXTREMELY sensitive, 8.1 allows you to push
const boat_impulse_factor = 75

func pushed_by_player(is_right):
	apply_central_impulse(Vector2(player_impulse_factor if is_right else -player_impulse_factor, 0))

func pushed_by_boat(is_right):
	apply_central_impulse(Vector2(boat_impulse_factor if is_right else -boat_impulse_factor, 0))
