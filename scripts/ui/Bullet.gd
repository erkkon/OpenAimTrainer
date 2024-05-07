extends Node3D

var target = Vector3() # Declare the target variable
const BULLET_SPEED = 1000.0 # Declare the BULLET_SPEED constant
var has_reached_target = false # Declare the has_reached_target variable
var hited = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(delta):
	
	if has_reached_target:
		if hited:
			queue_free()
		return

	# Calculate the bullet's velocity based on the target
	var direction = (target - global_transform.origin).normalized()
	var velocity = direction * BULLET_SPEED
	
	# Check if the bullet has reached the target
	if direction.dot(target - (global_transform.origin + velocity * delta)) < 0:
		global_transform.origin = target
		has_reached_target = true
	else:
		translate(velocity * delta) # Now velocity is recognized
func _on_timer_timeout():
	queue_free()
