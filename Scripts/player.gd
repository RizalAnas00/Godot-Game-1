extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX

const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var input_enabled = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var jump_count = 1
var max_jump = 0
var current_level = 0
#
#signal can_double_jump
#
func set_current_level(level):
	current_level = level
		# Only connect the signal if it's Level 2
	if current_level == 2:
		max_jump = 2
	
	if current_level != 2:
		max_jump = 0
		
# i made up this function, not exist in Godot
func _process_input():
	if not input_enabled:
		return
	
	var direction = Input.get_axis("move_left", "move_right")
	var is_rolling = Input.is_action_pressed("roll")  # Replace with your roll input

	if current_level == 2:
		if Input.is_action_just_pressed("jump") and jump_count < max_jump:
			print("JUMP ON LEVEL 2 STATE")
			jump()
			jump_count += 1
			print("Max count of jumps : ",max_jump)
	else:
		#Handle jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump()
			
	# Flip the sprite based on movement direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play appropriate animation based on state
	if is_on_floor():
		if is_rolling and direction != 0:
			animated_sprite.play("roll")
		elif direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Set horizontal velocity based on input
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _physics_process(delta):
	_process_input()  # Process input each frame

	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_floor():
		jump_count = 1

	move_and_slide()

func jump():
	velocity.y = JUMP_VELOCITY
	jump_sfx.play()
	animated_sprite.play("jump")

func death_and_jump():
	velocity.y = JUMP_VELOCITY
	jump_sfx.play()
	animated_sprite.play("jump")
	input_enabled = false
	
func idle_player():
	input_enabled = false
	#set_physics_process(false)
	set_process_input(false)
	if animated_sprite:
		animated_sprite.play("idle")
	else:
		print("Animated sprite not found!")  # Customize for your idle animation

func enable_player():
	input_enabled = true
	set_physics_process(true)
	set_process_input(true)

	
