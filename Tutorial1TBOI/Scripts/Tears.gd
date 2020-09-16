extends RigidBody2D
var tmr=0
var disable=0

func _on_tmr_distance_timeout():
	if disable==0:
		if tmr==0:
			linear_velocity+=Vector2(0,90)
			$tmr_distance.start(0.2)
		
		if tmr==1:
			delete()
			get_parent().sfx_play("res://Resources/sfx/splatter 0.wav",-7)
			disable=1
			
		tmr+=1
		
func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()


	

func _on_Tears_body_entered(_body):
	get_parent().sfx_play("res://Resources/sfx/tear block.wav",-7)
	disable=1
	delete()
		
func delete():
	linear_velocity=Vector2(0,0)
	$AnimationPlayer.play("splash",0,3)
