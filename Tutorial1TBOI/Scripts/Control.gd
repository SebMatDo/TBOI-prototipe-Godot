extends Control

onready var heart= load("res://Escenas/Heart.tscn")
onready var bar=load("res://Escenas/UI/bar_charge.tscn")
onready var player= get_parent().get_parent().get_node("Obj_Player")
var max_hp=0
var current_hp=0
var hearts=[]
var b 

func _ready():
	b=bar.instance()
	call_deferred("add_child",b)
	b.position.x+=50
	b.position.y+=20
	update()

func update():
	if max_hp<player.max_hp:
		var new_heart= heart.instance()
		call_deferred("add_child",new_heart)
		new_heart.position.x+=62+hearts.size()*15
		new_heart.position.y+=13
		new_heart.frame=2
		hearts.append(new_heart)
		max_hp+=2
		update()
#####CURRENT############
	if player.current_hp>current_hp:
		for i in player.current_hp:
			if hearts[i/2].frame==1:
				hearts[i/2].frame=0
			if hearts[i/2].frame==2:
				hearts[i/2].frame=1
			#if hearts[i].frame==2:
			#	hearts[i].frame=1
		current_hp+=1
		
	if player.current_hp<current_hp:
		var back=0
		while current_hp-player.current_hp!=0:
			if hearts[(hearts.size()-1)-back].frame==1:
				hearts[(hearts.size()-1)-back].frame=2
				current_hp-=1
				
			if hearts[(hearts.size()-1)-back].frame==0:
				hearts[(hearts.size()-1)-back].frame=1
				current_hp-=1
				
			back+=1
	if current_hp!=player.current_hp:
		update()
