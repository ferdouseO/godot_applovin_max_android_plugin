class_name MAXInitializer
extends MaxSingletonBridge

static var _plugin := _get_plugin("ApplovinMax")

var MAX_SDK_key : String = ""


func _init(sdk_key : String, initialization_listener: MAXInitializationListener) -> void:
	MAX_SDK_key = sdk_key
	_plugin.connect("applovin_initialized", func():	initialization_listener.applovin_initialized.call_deferred())


func initialize_applovin_max() -> void:
	_plugin.initialize_applovin(MAX_SDK_key)


func is_max_initialized() -> bool:
	return _plugin.get_is_applovin_initialized()


func display_mediation_debugger() -> void:
	_plugin.display_mediation_debugger()
