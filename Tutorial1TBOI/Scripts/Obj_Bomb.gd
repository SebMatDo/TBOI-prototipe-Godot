extends RigidBody2D
var fx_explode= load("res://Escenas/fx_bombexploded.tscn")
var player
var bombcolliding=0
func _ready():
	$AnimationPlayer.play("Explode")
	player=get_parent().get_node("Obj_Player")

	
func _on_AnimationPlayer_animation_finished(_anim_name):
	var fx=fx_explode.instance()
	get_parent().add_child(fx)
	fx.position=position
	fx.get_node("Sprite").frame=randi()%7
	queue_free()





func _physics_process(_delta):
	var r=get_node("RayCast2D")
	r.rotation=get_linear_velocity().angle()
	if r.is_colliding():
		if r.get_collider().is_in_group("Paredes") and bombcolliding==0:
			set_linear_velocity(-get_linear_velocity())


func _on_Obj_Bomb_body_entered(body):
	if body.is_in_group("Paredes"):
		set_collision_layer_bit(0,false)
		bombcolliding=1
		
		if player.position.x<position.x:
			linear_velocity=(Vector2(-25,0))
		if player.position.x>position.x:
			linear_velocity=(Vector2(25,0))
		if player.position.y<position.y:
			linear_velocity=(Vector2(0,-25))
		if player.position.y<position.y:
			linear_velocity=(Vector2(0,25))

		


func _on_Obj_Bomb_body_exited(body):
		if body.is_in_group("Paredes"):
			
			bombcolliding=0




func _on_Area2D_body_exited(body):
	if body.is_in_group("Player") :
		set_collision_layer_bit(0,true)
		set_collision_layer_bit(3,true)



func _on_VisibilityNotifier2D_viewport_entered(_viewport):
	$AnimationPlayer.play("Explode")


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	$AnimationPlayer.stop(true)
	set_linear_velocity(Vector2(0,0))
