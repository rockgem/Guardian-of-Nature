# A class representing the player (Guardian) in the game, extending CharacterBody2D for 2D physics.
# This is the heart of the Guardian’s journey to restore the forest!
class_name Player
extends CharacterBody2D

# The primary direction the Guardian is facing, starting downward.
# This helps determine animations and movement orientation!
var cardinal_direction: Vector2 = Vector2.DOWN

# The current movement direction based on player input, initialized as no movement.
# This guides the Guardian through the pixel art wilderness!
var direction: Vector2 = Vector2.ZERO

# The speed at which the Guardian moves, set to 100 units per second.
# Adjust this to control how swiftly they explore and heal the forest!
var move_speed: float = 100.0

# The current state of the Guardian (e.g., "idle" or "walk"), starting as idle.
# This drives the behavior and animations for different tasks!
var state: String = "idle"

# Reference to the AnimationPlayer node for playing animations, set up when ready.
# This brings the Guardian’s pixel art to life with smooth transitions!
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Reference to the Sprite2D node for rendering the Guardian’s appearance, set up when ready.
# This displays the Guardian’s charming pixel art sprite!
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the player node is initialized in the scene.
# Use this to set up the Guardian’s starting conditions in the forest!
func _ready():
	pass

# Called every frame, ignoring the delta parameter for now.
# Handles input and updates the Guardian’s movement direction and state.
# The || (OR) checks ensure animations update only when needed!
@warning_ignore("unused_parameter")
func _process(delta):
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	velocity = direction * move_speed
	if SetState() == true || SetDirection() == true:
		UpdateAnimation()
	pass

# Called every physics frame to move the Guardian using physics.
# move_and_slide() ensures smooth movement and collision handling in the forest!
func _physics_process(delta):
	move_and_slide()

# Determines if the Guardian’s direction should change based on movement.
# Returns true if the cardinal direction updates, triggering an animation update!
func SetDirection() -> bool:
	var new_dir: Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.x < 0 else Vector2.DOWN  # Note: Should use direction.y here
	if new_dir == cardinal_direction:
		return false
	cardinal_direction = new_dir
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1  # Flips sprite for left direction
	return true

# Determines if the Guardian’s state should change based on movement.
# Returns true if the state updates (e.g., from idle to walk), triggering an animation!
func SetState() -> bool:
	var new_state: String = "idle" if direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
	state = new_state
	return true

# Updates the Guardian’s animation based on the current state and direction.
# Plays an animation like "idle_down" or "walk_side" to reflect their actions!
func UpdateAnimation() -> void:
	animation_player.play(state + "_" + AnimDirection())
	pass

# Returns the animation direction suffix based on the cardinal direction.
# Helps create direction-specific animations (e.g., "down", "up", or "side")!
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
