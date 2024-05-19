extends CharacterBody2D


@export var speed = 300.0
@export var max_x = 850.0
@export_range(0, 2000) var jump_veloicty = 400.0
@export_range(0, 1) var coyote_time = 0.2
@export var dash = 50.0

var time_since_floor := 0.0
@onready var trail : Line2D = $Trail
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if global_position.x > max_x:
		global_position.x = max_x
	if global_position.x < - max_x:
		global_position.x = - max_x
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
		
	# Handle slap
	if Input.is_action_just_pressed("slap"):
		$AudioStreamPlayer2D.play()
		sprite.stop()
		sprite.play("slap")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	#Just walked left
	if velocity.x < 0:
		sprite.position.x = -100
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.position.x = 0
		sprite.flip_h = false

	move_and_slide()
	
	if not sprite.is_playing():
		sprite.play("idle")
