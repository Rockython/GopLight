extends Area2D



var Hero = null

func can_see_player():
	return Hero != null

func _on_RightArea_body_entered(body):
	Hero = null
	Hero = body


func _on_RightArea_body_exited(body):
	Hero = null
