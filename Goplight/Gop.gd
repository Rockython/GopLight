extends KinematicBody2D

const MAX_SPEED = 30
const ACCELERATION = 150
const FRICTION = 175

var velocity = Vector2.ZERO

onready var animationHero = $AnimationHero

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			animationHero.play("MoveRight")
		else:
			animationHero.play("MoveLeft")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, delta * ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
	velocity = move_and_slide(velocity)

