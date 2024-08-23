extends Node2D

const SPEED = 60
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_below: RayCast2D = $RayCastBelow
@onready var ray_cast_below_2: RayCast2D = $RayCastBelow2

var direction = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding() or not ray_cast_below.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding() or not ray_cast_below_2.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false

	position.x += direction * SPEED * delta
	
