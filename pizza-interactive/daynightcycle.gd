extends CanvasModulate

const MINUTES_PER_DAY = 1440 
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

signal time_tick(_day: int, _hour:int, _minute:int )

@export var gradient:GradientTexture1D
@export var INGAME_SPEED = 1.0
@export var INITIAL_HOUR = 12:
	set(h):
		INITIAL_HOUR = h
		time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR

var time:float = 0.0 
var past_minute:float = -1.0 

func _ready() -> void:
	time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta  * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	var value = (sin(time -  PI / 2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
	_recalculate_time()


func _recalculate_time() -> void: 
	var total_minutes = int(time /  INGAME_TO_REAL_MINUTE_DURATION )
	
	@warning_ignore("integer_division")
	var _day = int(total_minutes / MINUTES_PER_DAY)
	
	var _current_day_minutes = total_minutes % MINUTES_PER_DAY
	
	@warning_ignore("integer_division")
	var _hour = int(_current_day_minutes / MINUTES_PER_HOUR)
	var _minute = int(_current_day_minutes % MINUTES_PER_HOUR)
	
	if past_minute != _minute:
		past_minute = _minute
		time_tick.emit(_day, _hour, _minute)
