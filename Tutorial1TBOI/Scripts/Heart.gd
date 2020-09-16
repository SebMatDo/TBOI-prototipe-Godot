extends Area2D
var sfx
var db


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		if body.max_hp>body.current_hp:
			if get_parent().frame==1:
				body.current_hp+=1
				sfx="res://Resources/sfx/heartpickup.wav"
				db=0
				
			if get_parent().frame==0:
				if body.max_hp-body.current_hp==1:
					body.current_hp+=1
				if body.max_hp-body.current_hp>1:
					body.current_hp+=2
				sfx="res://Resources/sfx/pickupheartfull.wav"
				db=-15
			
			get_parent().queue_free()
			body.ui.update()	
			body.audio.sfx_play(sfx,db)
