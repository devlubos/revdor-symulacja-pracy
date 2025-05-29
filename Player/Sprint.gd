extends Node2D

enum  {
	ACTIVE,
	RELOAD,
	EXHAUSTED,
	INACTIVE
}

var exhausted_time = 1
var reload_time = 5
var stamina_status = ACTIVE

var stamina_max_value = 3
var stamina: float = 0

onready var exhausted_delay_timer: Timer = $ExhaustedDelayTimer
onready var stamina_timer: Timer = $StaminaTimer
onready var progress_bar = $ProgressBar

func _ready():
	progress_bar.max_value = stamina_max_value
	stamina = stamina_max_value
	stamina_status = RELOAD

func _process(delta):
	self.rotation = -get_parent().rotation
	match  stamina_status: 
		ACTIVE:
			#I am active and decrease stamina during time
			stamina = stamina_timer.time_left
			pass
		RELOAD:
			#I am loading stamina up to maximum value
			_change_stamina_value(float(stamina_max_value * delta / reload_time ))
			if stamina == stamina_max_value:
				stamina_status = INACTIVE
			pass
		EXHAUSTED:
			#I wait before starting to reload
			pass
		INACTIVE:
			#hide bar
			progress_bar.visible = false
			pass
	progress_bar.value = stamina
	if progress_bar.value < stamina_max_value * 0.3:
		progress_bar.tint_progress = Color(0.8,0,0)
	else:
		progress_bar.tint_progress = Color(0.8,0.8,0)

func _change_stamina_value(delta_value: float):
	stamina += delta_value
	if stamina <= 0:
		stamina = 0
	if stamina >= stamina_max_value:
		stamina = stamina_max_value

func get_stamina_status() -> bool:
	return stamina_status == ACTIVE

# outside call to start timer
func activate_sprint():
	if stamina > 0:
		exhausted_delay_timer.stop()
		stamina_timer.start(stamina)
		stamina_status = ACTIVE
		progress_bar.visible = true

#outside call to stop timer
func deactivate_sprint():
	exhausted_delay_timer.start(exhausted_time)
	stamina_status = EXHAUSTED

func _on_ExhaustedDelayTimer_timeout():
	stamina_status = RELOAD

func _on_StaminaTimer_timeout():
	deactivate_sprint()
