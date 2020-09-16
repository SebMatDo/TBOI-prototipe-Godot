extends Node2D
var array_sfx=[]
var background
var bc_music="res://Resources/sfx/background/the cellar alt intro.ogg"
var iniciar_nivel=0
var list_rooms=[]
var random_seed

func _ready():
	randomize()
	random_seed=randi()
	seed(random_seed)
	print(random_seed)
	get_node("Roomer").max_rooms=randi()%10+5
	print(get_node("Roomer").max_rooms)
	get_node("Room").mainroom=1
	get_node("Room").valor=10000
	background=AudioStreamPlayer.new()
	add_child(background)
	background.set_stream(load(bc_music))
	background.set_volume_db(-8)
	background.play()
	background.connect("finished",self,"new_bc")
	iniciar_nivel=1
	print(bc_music,iniciar_nivel)
	var room=get_node("/root/global_file").load("res://Resources/levels/rooms/basement.txt")
	var new_s=""
	for i in room.length():
		if room[i]!=",":
			new_s+=room[i]
		if room[i]==",":
			list_rooms.append(new_s)
			new_s=""
func _process(_delta):
#warning-ignore:return_value_discarded
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene() 
	if Input.is_action_just_pressed("ui_end"):
		get_node("Camera2D").zoom=Vector2(1,1)
	if Input.is_action_just_pressed("ui_home"):
		get_node("Camera2D").zoom=Vector2(10,10)
	if Input.is_action_just_pressed("ui_f"):
		OS.window_fullscreen=!OS.window_fullscreen
		get_node("Obj_Player").delay+=0.1
		
func sfx_play(sfx,db):
	var audio= AudioStreamPlayer.new()
	add_child(audio)
	audio.set_stream(load(sfx))
	audio.set_volume_db(db)
	audio.play()
	array_sfx.append(audio)
	audio.connect("finished",self,"sfx_delete")
	
func sfx_delete():
	if array_sfx.size()>0:
		for i in array_sfx.size():
			if array_sfx[0].is_playing()==false:
				array_sfx[0].queue_free()
				array_sfx.remove(0)

func new_bc():
	if iniciar_nivel==1:
		bc_music="res://Resources/sfx/background/the cellar alt.ogg"
	background.set_stream(load(bc_music))
	background.play()

func ui_death(d):
	var ui_d=load("res://Escenas/UI/death_ui.tscn")
	var ui_death=ui_d.instance()
	add_child(ui_death)
	ui_death.seed_is("seed: "+str(random_seed))
