extends Line2D

var queue : Array
@export var MAX_LENGHT : int

func _process(_delta: float) -> void:
	var pos = get_parent().global_position
	if MAX_LENGHT != 0 and not Input.is_action_pressed("ui_accept"):
		queue.push_front(pos)

	if queue.size() > MAX_LENGHT:
		queue.pop_back()
		
	clear_points()
	
	for point in queue:
		add_point(point)
