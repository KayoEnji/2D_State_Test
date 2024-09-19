extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var hsm: LimboHSM = $LimboHSM
@onready var idle_state: LimboState = $LimboHSM/Idle
@onready var move_state: LimboState = $LimboHSM/Move
@onready var jump_state: LimboState = $LimboHSM/Jump

var ActiveState: LimboState = null:
	get:
		return hsm.get_active_state()

func _ready() -> void:
	hsm.add_transition(idle_state, move_state, &"move_start")
	hsm.add_transition(move_state, idle_state, &"move_stop")
	hsm.add_transition(hsm.ANYSTATE, jump_state, &"jump_start")
	hsm.add_transition(jump_state, hsm.ANYSTATE, &"jump_stop")
	
	hsm.initialize(self)
	hsm.set_active(true)
	
	# TODO: fuck this shit
	hsm.blackboard.set_var(&"speed", 0.0)
	hsm.blackboard.set_var(&"direction", 0.0)
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if ActiveState.blackboard.get_var(&"is_jumping") and is_on_floor():
		jump()
	
	var speed = ActiveState.blackboard.get_var(&"speed")
	var direction = ActiveState.blackboard.get_var(&"direction")
	
	move(direction * speed)
	move_and_slide()

func jump():
	velocity.y = JUMP_VELOCITY

func move(direction: float):
	# Get the input direction and handle the movement/deceleration.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
