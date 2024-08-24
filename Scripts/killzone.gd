extends Area2D

@onready var timer: Timer = $Timer
@onready var hurt_sfx: AudioStreamPlayer2D = $hurtSFX

func _on_body_entered(body: Node2D):
	print("DEAD")
	Engine.time_scale = 0.5
	hurt_sfx.play()
	body.get_node("CollisionShape2D").queue_free()
	body.get_node("AnimatedSprite2D").flip_v = true
	#body.rotate(180)
	timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
