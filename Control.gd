extends Control





func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_StartButton1_pressed():
	$StartButton1.hide()
	$StartButton.hide()
	emit_signal("start_game")


