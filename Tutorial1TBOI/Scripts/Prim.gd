extends Node2D

var recorrer=preload("res://Escenas/Recorrer.tscn")
var pos=Vector2(0,0)
var rposition=Vector2(0,0)
var n_nodos=[]
var total_nodos=0
var total_recorrer=0
var goto
var can=0
var recorrido=[]
func _process(delta):
	