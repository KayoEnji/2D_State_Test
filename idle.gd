class_name IdleState
extends LimboState

@export var animation_player: AnimationPlayer
@export var animation_name := &"idle"

## Called once, when state is initialized.
func _setup() -> void:
	pass

## Called when state is entered.
func _enter() -> void:
	print("idle enter")
	animation_player.play(animation_name)
	blackboard.set_var(&"speed", 0.0)

## Called when state is exited.
func _exit() -> void:
	print("idle exit")

## Called each frame when this state is active.
func _update(delta: float) -> void:
	# TODO: better way of getting input
	var direction = Input.get_axis("move_left", "move_right")
	
	if absf(direction) > 0:
		dispatch(&"move_start")
