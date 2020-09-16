extends KinematicBody2D

var bomb=load("res://Escenas/Obj_Bomb.tscn")
var max_speed=130
var acceleration=max_speed/4
var friction=4
var movement=Vector2()
var vel=Vector2()
var norm=Vector2()
var quieto=0
var canshot=1
export var delay=0.1
var shotdistance=0.35
var shotvel=350
var dmg=2.5
var disparando=0
var dirdisparo=Vector2()
var ojo=false
var inmune=0
var max_hp=4 
var current_hp=2
var tear= preload("res://Escenas/Tears.tscn")
onready var ui=get_parent().get_node("CanvasLayer/Control") 
onready var animator=$Sprite/AnimationPlayer
onready var sprite=$Sprite
onready var animatorhead=$Spr_Head/AnimationHead
onready var spritehead= $Spr_Head
onready var audio=get_parent()

func _ready():
	animator.play("IsaacIdle")
	animatorhead.play("IsaacHeadDown")
	
func _physics_process(delta):
	
	
	if quieto==0: ###  movimiento### 
	 	### Direccion ###
		movement.x=-int(Input.is_action_pressed("ui_a")) + int(Input.is_action_pressed("ui_d")) ## Resto al valor vector x si left, le sumo si right
		movement.y=-int (Input.is_action_pressed("ui_w"))+ int(Input.is_action_pressed("ui_s")) ## vector y
	
	##### Aceleracion #####
		if abs(movement.x)==1 or abs(movement.y)==1:
			acceleration+=max_speed/20
			acceleration=clamp(acceleration,0,max_speed)
			norm=movement.normalized()*acceleration
			vel=norm
			norm=move_and_slide(norm)
			
##### MOVIMIENTO CON FRICCION AL FRENAR# ####
		if movement.x==0 and movement.y==0:
			acceleration=0
			vel.x-=vel.x*friction*delta
			vel.y-=vel.y*friction*delta
			vel=move_and_slide(vel)
			
######## ATAQUES ############
		if canshot==1:
			if Input.is_action_pressed("ui_left"):
				dirdisparo=Vector2(-1,0)
				animatorhead.play("IsaacHeadL", 0,1/delay)
				spritehead.flip_h=true
				disparar()
				
		if canshot==1:
			if Input.is_action_pressed("ui_right"):
				dirdisparo=Vector2(1,0)
				animatorhead.play("IsaacHeadL", 0,1/delay)
				spritehead.flip_h=false
				disparar()
				
		if canshot==1:
			if Input.is_action_pressed("ui_up"):
				dirdisparo=Vector2(0,-1)
				animatorhead.play("IsaacHeadUp", 0,1/delay)
				disparar()
				
		if canshot==1:
			if Input.is_action_pressed("ui_down"):
				dirdisparo=Vector2(0,1)
				animatorhead.play("IsaacHeadDown", 0,1/delay)
				disparar()
				
		if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right")  and not Input.is_action_pressed("ui_down")  and not Input.is_action_pressed("ui_up"):
			if animatorhead.get_current_animation_position()>0.3:
				disparando=0
		
		if Input.is_action_just_pressed("ui_e"):
			var b=bomb.instance()
			get_parent().add_child(b)
			b.position=position
			
### ANIMACIONES #############
		if movement.y==1:
			animator.play("IsaacWalkY",0,max_speed/100)
			if disparando==0:
				animatorhead.play("IsaacHeadDown",0,0)
			
		if movement.y==-1:
			animator.play("IsaacWalkY",0,max_speed/100)
			
			if disparando==0:
				animatorhead.play("IsaacHeadUp",0,0)

		if movement.x==1 and movement.y==0:
			animator.play("IsaacWalkX",0,max_speed/100)
			if disparando==0:
				animatorhead.play("IsaacHeadL",0,0)
				spritehead.flip_h=false
			sprite.flip_h=false
			
			
		if movement.x==-1 and movement.y==0:
			animator.play("IsaacWalkX",0,max_speed/100)
			if disparando==0:
				animatorhead.play("IsaacHeadL",0,0)
				spritehead.flip_h=true
			sprite.flip_h=true
			
			
		if movement.x==0 and movement.y==0:
			animator.play("IsaacIdle")
			if disparando==0:
				animatorhead.play("IsaacHeadDown",0,0)
			

func _on_tmr_shoot_timeout():
	canshot=1


func disparar():
	ojo=!ojo
	disparando=1
	var tr=tear.instance()
	get_parent().add_child(tr)
	audio.sfx_play("res://Resources/sfx/blobby wiggle 3.wav",-10)
	
	if dirdisparo==Vector2(-1,0) or dirdisparo==Vector2(1,0):
		tr. set_linear_velocity(Vector2(dirdisparo.x*shotvel,5))
		if ojo==true:
			tr.position=Vector2(position.x,position.y-15)
		
		if ojo==false:
			tr.z_index+=1
			tr.position=Vector2(position.x,position.y-10)
	
	if dirdisparo==Vector2(0,1):
		tr.z_index+=1
		
	if dirdisparo==Vector2(0,-1) or dirdisparo==Vector2(0,1):
		tr. set_linear_velocity(dirdisparo*shotvel)
		if ojo==false:
			tr.position=Vector2(position.x-5,position.y-15)
		if ojo==true:
			tr.position=Vector2(position.x+5,position.y-15)
				
	
	tr.get_node("tmr_distance").start(shotdistance)
	tr.get_node("Sprite").frame=int(dmg*2)
	tr.get_node("CollisionShape2D").shape.radius=3+(dmg*2)
	$tmr_shoot.start(delay)
	canshot=0
			
		
func golpeado():
	$Sprite.visible=false
	$Spr_Head.visible=false
	$spr_hit.visible=true
	$spr_hit/AnimationHit.play("Hit")
	var h=randi()%3
	if h==0:
		audio.sfx_play("res://Resources/sfx/hurt grunt 1.wav",0)
	if h==1:
		audio.sfx_play("res://Resources/sfx/hurt grunt 2.wav",0)
	if h==2:
		audio.sfx_play("res://Resources/sfx/hurt grunt .wav",0)
	
	inmune=1
	
	$tmr_hit.start()
	
	if current_hp==1:
		morir()


func _on_tmr_hit_timeout():
	if current_hp>=1:
		$Sprite.visible=true
		$Spr_Head.visible=true
		$spr_hit.visible=false
		inmune=0

func morir():
	$Sprite.visible=false
	$Spr_Head.visible=false
	$spr_hit.visible=true
	$spr_hit/AnimationHit.play("death",-1,1.8)
	quieto=1
	var h=randi()%3
	if h==0:
		audio.sfx_play("res://Resources/sfx/isaac dies new 1.wav",0)
	if h==1:
		audio.sfx_play("res://Resources/sfx/isaac dies new 2.wav",0)
	if h==2:
		audio.sfx_play("res://Resources/sfx/isaac dies new.wav",0)
	$spr_hit/AnimationHit.connect("animation_finished",get_parent(),"ui_death")
	
	
	
	
	
	
	
