extends CharacterBody2D


@export var speed = 300.0
@export var max_x = 850.0
@export_range(0, 2000) var jump_veloicty = 400.0
@export_range(0, 1) var coyote_time = 0.2
@export var dash = 50.0
@export var added_velocity_drag = 3.0
@export var caterpillar_force = 750

var time_since_floor := 0.0
@onready var trail : Line2D = $Trail
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_box = $DamageArea
@onready var hurt_box = $HurtBox

var walk_direction = 1

var added_velocity := Vector2.ZERO

func _ready() -> void:
	damage_box.monitorable = false

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
		damage_box.monitorable = true
		damage_box.position = abs(damage_box.position) * walk_direction
		sprite.stop()
		sprite.play("slap")
	else:
		damage_box.monitorable = false
		damage_box.position = abs(damage_box.position) * -1 * walk_direction

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	#Just walked left
	if velocity.x < 0:
		sprite.position.x = -50
		sprite.flip_h = true
		walk_direction = -1
	elif velocity.x > 0:
		sprite.position.x = 50
		sprite.flip_h = false
		walk_direction = 1
	
	velocity.x /= (added_velocity.distance_squared_to(Vector2.ZERO) / caterpillar_force * 2 + 1)
	
	velocity.x += added_velocity.x
	added_velocity.x -= added_velocity_drag * added_velocity.x * delta
	
	if abs(added_velocity.x) < 0.1:
		added_velocity.x = 0

	move_and_slide()
	
	if not sprite.is_playing():
		sprite.play("idle")


func _on_hurt_box_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var normalized = (global_position - area.global_position).normalized()
	added_velocity.x = normalized.x * caterpillar_force
	if normalized.y < -0.25:
		normalized.y = -1.0
	if normalized.y > 0.0:
		normalized.y = -0.65
	velocity.y = normalized.y *  caterpillar_force * (1.75 - abs(normalized.x))
