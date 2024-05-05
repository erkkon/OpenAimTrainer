extends Node3D

var target = Vector3() # Declare the target variable
const BULLET_SPEED = 500.0 # Declare the BULLET_SPEED constant
var has_collided = false # Declare the has_collided variable


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _physics_process(delta):
	if has_collided:
		return

	# Calculate the bullet's velocity based on the target
	var velocity = (target - global_transform.origin).normalized() * BULLET_SPEED
	
	translate(velocity * delta) # Now velocity is recognized

	# Check for collision
	var space_state = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = global_transform.origin
	ray_query.to = global_transform.origin + velocity * delta
	ray_query.collision_mask = 1
	var result = space_state.intersect_ray(ray_query)

	if result:
		velocity = Vector3() # Stop the bullet
		has_collided = true # Set has_collided to true

func _on_timer_timeout():
	queue_free()
