extends RigidBody2D
# Change the speed when needs be to fit the pace
@export var speed = 200
var screen_size
var max_speed = 300
var jump_force = 1000
var is_jumping = false


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

	
#func _physics_process(delta):
	#var velocity = Vector2(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("jump"): 
		apply_impulse(Vector2(0, -jump_force))
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	apply_central_impulse(velocity)
	
	
	if Input.is_action_pressed("sprint") and Input.is_action_pressed("move_right"):
		speed = 600
	elif Input.is_action_pressed("sprint") and Input.is_action_pressed("move_left"):
		speed = 600
	else:
		speed = 400
	
	if Input.is_action_pressed("dash") and Input.is_action_pressed("move_right"):
		speed = 2000
	if Input.is_action_pressed("dash") and Input.is_action_pressed("move_left"):
		speed = 2000
		
	var current_velocity = get_linear_velocity()
	var current_speed = current_velocity.length()
	if current_speed > max_speed:
		current_velocity = current_velocity.normalized() * max_speed
		set_linear_velocity(current_velocity)


#func start(pos):
	#position = pos
	#show()
	#$CollisionShape2D.disabled = false
