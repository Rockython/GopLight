extends Area2D



var Hero1 = null

func can_see_player():
	return Hero1 != null

func _on_UpArea_body_entered(body):
	Hero1 = null
	Hero1 = body


func _on_UpArea_body_exited(body):
	Hero1 = null
