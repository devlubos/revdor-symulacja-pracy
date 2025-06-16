class_name Stamina
extends Node

enum  {
	ACTIVE,
	RELOAD,
	EXHAUSTED,
	INACTIVE
}

var exhausted_time = 1
var reload_time = 5
var stamina_status = ACTIVE

export(float) var stamina_max_value = 3
onready var stamina: float = stamina_max_value setget ,get_stamina

onready var stamina_exhausted_timer: Timer = $StaminaExhaustedTimer
onready var stamina_timer: Timer = $StaminaTimer

func _ready():
	stamina = stamina_max_value
	stamina_status = RELOAD

func _process(delta):
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
			pass
		INACTIVE:
			pass

func activate_stamina():
	if stamina > 0:
		stamina_exhausted_timer.stop()
		stamina_timer.start(stamina)
		stamina_status = ACTIVE

func deactivate_stamina():
	stamina_exhausted_timer.start(exhausted_time)
	stamina_status = EXHAUSTED

func get_stamina_status() -> bool:
	return stamina_status == ACTIVE

func get_stamina() -> float:
	return stamina

func get_max_stamina() -> float:
	return stamina_max_value

func is_stamina_bar_visible() -> bool:
	return stamina_status != INACTIVE

func _change_stamina_value(delta_value: float):
	stamina += delta_value
	if stamina <= 0:
		stamina = 0
	if stamina >= stamina_max_value:
		stamina = stamina_max_value

func _on_StaminaTimer_timeout():
	deactivate_stamina()

func _on_StaminaExhaustedTimer_timeout():
	stamina_status = RELOAD
