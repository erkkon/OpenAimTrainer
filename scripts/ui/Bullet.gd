extends Node3D

var velocity = Vector3() # Declare the velocity variable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(delta):
	translate(velocity * delta) # Now velocity is recognized

func _on_timer_timeout():
	queue_free()
