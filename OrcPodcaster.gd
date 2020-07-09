extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
#var CircleOfDeath=preload("res://MagicStrike.tscn")
export  var ACCELERATION = 500
export  var MAX_SPEED = 100
export var FRICTION = 2000


var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var state = CHASE
enum{
	IDLE,
	WANDER,
	CHASE
}

onready var MagicTimer = 0
onready var orcStats = $OrcStats
onready var playerDetectionZone = $PlayerDetectionZone
onready var animationOrc = $AnimationOrc
onready var leftArea = $LeftArea
onready var rightArea = $RightArea
onready var animationStatus = $OrcAnimationTree
onready var Hero = null
onready var MagicStrike = $MagicStrike
onready var upArea = $UpArea
onready var downArea = $DownArea
onready var Hero1 = null
onready var animationStreet = animationStatus.get("parameters/playback")
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 50 * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, 600 * delta )
			seek_player()
			#animationOrc.play("IdleDown")
		WANDER:
			pass
		CHASE:
			var player = playerDetectionZone.player
			var LeftArea =  leftArea.Hero
			var UpArea = upArea.Hero1
			var DownArea = downArea.Hero1
			var RightArea = rightArea.Hero
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				if velocity != Vector2.ZERO:
					print (velocity)
					animationStatus.set("parameters/OrcIdle/blend_position", velocity)
					animationStatus.set("parameters/OrcWalk/blend_position", velocity)
					
					animationStreet.travel("OrcWalk")
					
					#velocity = velocity.move_toward(velocity * MAX_SPEED, delta * ACCELERATION)
				#else:
					#state = IDLE
					#animationStatus.set("parameters/OrcIdle/blend_position", velocity)
					#animationStatus.set("parameters/OrcWalk/blend_position", velocity)
					#animationStreet.travel("OrcIdle")
					#velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
			else:
				animationStreet.travel("OrcIdle")
				velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
				
				
			
				
				
				
			
			
	velocity = move_and_slide(velocity)
		
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
	
func magic_up_state():
	#stop=1
	animationOrc.play("magicUp")
	$MagicStrike.play(0.0)
	var circle = MagicStrike.instance()
	circle.position = Hero.position
	get_parent().add_child(circle)
	#attack=0
	
	
func magic_up_animation_finished():
	state = IDLE
	
func _on_Hurtbox_area_entered(area):
	orcStats.health -=area.damage
	knockback = area.knockback_vector * 50


func _on_Hurtbox_area_exited(area):
	pass # Replace with function body.


func _on_OrcStats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position


func _on_LeftArea_body_entered(body):
	pass # Replace with function body.


func _on_LeftArea_body_exited(body):
	pass # Replace with function body.


func _on_RightArea_body_entered(body):
	pass # Replace with function body.


func _on_RightArea_body_exited(body):
	pass # Replace with function body.
