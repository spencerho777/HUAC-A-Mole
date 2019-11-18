extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = str(value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if value != int(self.text):
		self.text = str(value)
