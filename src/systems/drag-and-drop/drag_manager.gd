extends Node3D

const RAY_LENGTH = 2500

var dragging = false
var current: DraggableComponent = null
var ray_result = null


func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	var origin = get_parent().project_ray_origin(mousepos)
	var direction = get_parent().project_ray_normal(mousepos)
	var remaining_length = RAY_LENGTH
	
	while remaining_length > 0:
		var end = origin + direction * remaining_length
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true
		
		var result = space_state.intersect_ray(query)
		if !result:
			ray_result = null
			break
		elif result.collider.is_in_group("draggable"):
			ray_result = result
			break
		
		remaining_length -= origin.distance_to(result.position)
		origin = result.position + direction * 0.01
	
	if !current:
		return
	
	# Get drag position
	var plane = Plane(Vector3(0, 1, 0), Vector3(0, 1, 0))
	origin = get_parent().project_ray_origin(mousepos)
	var plane_intersection = \
			plane.intersects_ray(origin, origin + direction * 1000)
	if plane_intersection:
		current.drag_move(plane_intersection)


func _input(event):
	if current and event.is_action_pressed("rotate_left"):
		current.drag_rotate(90)
		return
	elif current and event.is_action_pressed("rotate_right"):
		current.drag_rotate(-90)
		return
	
	if current and event.is_action_released("drag"):
		current.drag_end()
		dragging = false
		current = null
		return
	
	if !current and ray_result and event.is_action_pressed("drag"):
		var collider = ray_result.collider
		if collider is not Node:
			return
		
		dragging = true
		current = ray_result.collider
		current.drag_start(ray_result["position"])
		current.tree_exiting.connect(_on_current_tree_exiting)


func _on_current_tree_exiting():
	if current:
		current.tree_exiting.disconnect(_on_current_tree_exiting)
		current.drag_end()
		current = null
	dragging = false
