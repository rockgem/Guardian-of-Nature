
# A base class for managing different states of the player (e.g., idle, walking, planting).
# This allows the Guardian to switch behaviors smoothly as they restore the forest!
class_name State_Attack
extends State

var attacking : bool = false

@export_range(1,20,0.5) var decelerate_speed : float = 5.0
@export var attack_sound : AudioStream
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var walk: State_Walk = $"../Walk"
@onready var idle: State_Idle = $"../Idle"
#@onready var hurt_box: HurtBox = %AttackHurtbox

#@onready var attack_animation: AnimationPlayer = $"../../Sprite2D/AttackEffects/AnimationPlayer"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"




# Called when this state is entered (e.g., switching from idle to walking).
# Use this to start animations or set initial conditions for the Guardian’s journey!
func Enter() -> void:
	player.UpdateAnimation("attack")
	#attack_animation.play( "attack")
	animation_player.animation_finished.connect( EndAttack )
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range( 0.9, 1.1 )
	audio.play()
	
	attacking = true
	
	await get_tree().create_timer( 0.075 ).timeout
	#hurt_box.monitoring = true 
	pass

# Called when this state is exited (e.g., moving from walking to planting).
# Clean up or reset anything here to keep the Guardian’s path clear and green!
func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAttack )
	attacking = false
	#hurt_box.monitoring = false
	pass

# Called every frame during the _process loop, with the time step (delta) in seconds.
# Handle non-physics updates here, like updating the Guardian’s animation or UI.
# Return a new state if the Guardian needs to transition (e.g., to a new task)!
func Process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
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
	return null

func EndAttack( _newAnimName: String) -> void:
	attacking = false
