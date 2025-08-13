
# A base class for managing different states of the player (e.g., idle, walking, planting).
# This allows the Guardian to switch behaviors smoothly as they restore the forest!
class_name State_Idle
extends State

@onready var walk: State_Walk = $"../Walk"
@onready var attack: State_Attack = $"../Attack"


# Called when this state is entered (e.g., switching from idle to walking).
# Use this to start animations or set initial conditions for the Guardian’s journey!	
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass

# Called when this state is exited (e.g., moving from walking to planting).
# Clean up or reset anything here to keep the Guardian’s path clear and green!
func Exit() -> void:
	pass

# Called every frame during the _process loop, with the time step (delta) in seconds.
# Handle non-physics updates here, like updating the Guardian’s animation or UI.
# Return a new state if the Guardian needs to transition (e.g., to a new task)!
func Process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

# Called every physics frame during the _physics_process loop, with the time step (delta) in seconds.
# Handle physics-related updates here, like moving the Guardian through the forest.
# Return a new state if a physics event triggers a transition (e.g., hitting a barrier)!
func Physics(_delta: float) -> State:
	return null

# Called when an input event occurs (e.g., key press or mouse click).
# Use this to check player actions, like planting a tree or dodging poachers.
# Return a new state if the input changes the Guardian’s current task!
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
