extends Node2D

var SPEED = 60
var input_enabled = true

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_below: RayCast2D = $RayCastBelow
@onready var ray_cast_below_2: RayCast2D = $RayCastBelow2

var direction = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _ready():
	#var killzone_slime = preload("res://Scenes/killzone.tscn")
	#var killzone = killzone_slime.instantiate()
	#add_child(killzone)
	
func _process(delta):
	if not input_enabled:
		animated_sprite_2d.flip_h = true
		return
		
	if ray_cast_right.is_colliding() or not ray_cast_below.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding() or not ray_cast_below_2.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false

	position.x += direction * SPEED * delta
	
func idle_slime():
	input_enabled = false
	set_process(false)
	set_process_input(false)
	if animated_sprite_2d:
		animated_sprite_2d.play("default")
	else:
		print("Animated sprite not found!")  # Customize for your idle animation

func enable_slime():
	input_enabled = true
	set_process(true)
	set_process_input(true)
