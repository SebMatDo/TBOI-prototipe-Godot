extends Node2D
func _ready():
	get_parent().sfx_play("res://Resources/sfx/boss explosions 0.wav",-10)
	yield(get_tree().create_timer(0.2), "timeout")
	$Area2D.queue_free()
	
	
func _on_Area2D_area_entered(area):
	if area.is_in_group("Roca"):
		area.destruir()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Roca"):
		body.destruir()
	if body.is_in_group("Player") :
		if body.inmune==0:
			body.golpeado()
			body.current_hp-=1
			body.ui.update()
		
