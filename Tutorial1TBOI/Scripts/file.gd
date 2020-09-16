extends Node


func save(path,content):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(content)
	print(path)
	file.close()
	
func load(path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
