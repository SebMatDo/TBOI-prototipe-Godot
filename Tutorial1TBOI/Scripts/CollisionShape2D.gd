extends CollisionShape2D

func _ready():
	var height=ProjectSettings.get("display/window/size/height")/2
	var width=ProjectSettings.get("display/window/size/width")/2
	shape=RectangleShape2D.new()
	shape.set_extents(Vector2(width,height))
