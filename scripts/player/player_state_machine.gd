# A state machine class for controlling the Guardian’s behavior and transitions.
# This manages which “state” the player is in—like idle, walking, or performing special actions!
class_name PlayerStateMachine
extends Node

# An array of all possible states (e.g., IdleState, WalkState, InteractState) attached as children.
# This holds every behavioral phase the Guardian can enter!
var states : Array[State]

# Tracks the previous state before switching—useful for transitions or re-entry behavior.
# Like remembering if the Guardian was walking before interacting with nature!
var prev_state : State

# The currently active state the Guardian is operating in.
# This state controls animations, physics, and input responses each frame.
var current_state : State

# Called when the PlayerStateMachine is initialized in the scene.
# Disables its own process mode until a state is set up during runtime.
func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass

# Called every frame—delegates the logic to the current state’s Process method.
# This is where real-time logic like idle animations or environmental checks happen!
func _process(delta):
	ChangeState(current_state.Process(delta))
	pass

# Called every physics frame—delegates movement or collision responses to the active state.
# For example, WalkState might handle pixel-perfect movement through the terrain here!
func _physics_process(delta):
	ChangeState(current_state.Physics(delta))
	pass

# Captures player input that isn’t handled elsewhere—delegates it to the state’s input handler.
# This allows context-sensitive input, like pressing a button to restore a corrupted tree!
func _unhandled_input(event):
	ChangeState(current_state.HandleInput(event))
	pass

# Initializes the state machine by assigning the Guardian reference to the first state.
# Automatically collects all valid State nodes from children and activates the first one.
func Initialize(_player : Player) -> void:
	states = []

	for c in get_children():
		if c is State:
			states.append(c)
	
	if states.size() > 0:
		states[0].player = _player
		ChangeState(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT  # Re-enable processing now that we have a state!

# Handles transitions between states.
# Ensures proper exit and entry methods are called during a shift—like fading animations or resetting logic!
func ChangeState(new_state : State) -> void:
	if new_state == null or new_state == current_state:
		return  # Avoid redundant transitions or null references
	
	if current_state:
		current_state.Exit()  # Clean up the old state before switching
	
	prev_state = current_state
	current_state = new_state
	current_state.Enter()  # Prepare the new state with any setup or animation triggers
