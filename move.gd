extends LimboState

@export var move_speed: float = 2.0

## Called once, when state is initialized.
func _setup() -> void:
	pass

## Called when state is entered.
func _enter() -> void:
	print("move enter")
	blackboard.set_var(&"speed", move_speed)

## Called when state is exited.
func _exit() -> void:
	print("move exit")

## Called each frame when this state is active.
func _update(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	blackboard.set_var(&"direction", direction)
	
	print("%s * %s" % [blackboard.get_var(&"direction"), blackboard.get_var(&"speed")])
	
	if not absf(direction) > 0:
		dispatch(&"move_stop")
