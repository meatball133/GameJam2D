extends CharacterBody2D


@export var speed = 300.0
@export_range(0, 2000) var jump_veloicty = 400.0
@export_range(0, 1) var coyote_time = 0.2
@export var dash = 50.0

var time_since_floor := 0.0
var trail : Line2D

func _ready() -> void:
	trail = $Trail

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		trail.MAX_LENGHT = 0
	else:
		trail.MAX_LENGHT = 30
	
	# Coyote time
	time_since_floor += delta
	if is_on_floor():
		time_since_floor = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and time_since_floor <= coyote_time:
		velocity.y = - jump_veloicty
	
	if abs(%Music.distance_to_beat()) < 0.01 and is_on_floor():
		%Glass.play(0.0)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
