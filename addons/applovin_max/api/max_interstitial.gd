class_name MAXInterstitial
extends MaxSingletonBridge

static var _plugin := _get_plugin("MaxInterstitial")

var MAX_interstitial_ad_id : String = ""


func _init(ad_unit_id : String, interstitial_listener: MAXInterstitialListener) -> void:
	MAX_interstitial_ad_id = ad_unit_id
	_plugin.connect("interstitial_ad_loaded", func():	interstitial_listener.interstitial_ad_loaded.call_deferred())
	_plugin.connect("interstitial_ad_load_failed", func(error: String):	interstitial_listener.interstitial_ad_load_failed.call_deferred(error))
	_plugin.connect("interstitial_ad_displayed", func():	interstitial_listener.interstitial_ad_displayed.call_deferred())
	_plugin.connect("interstitial_ad_display_failed", func(error: String):	interstitial_listener.interstitial_ad_display_failed.call_deferred(error))
	_plugin.connect("interstitial_ad_closed", func():	interstitial_listener.interstitial_ad_closed.call_deferred())
	_plugin.connect("interstitial_ad_clicked", func():	interstitial_listener.interstitial_ad_clicked.call_deferred())
	_plugin.connect("interstitial_ad_not_ready", func():	interstitial_listener.interstitial_ad_not_ready.call_deferred())


func load_interstitial() -> void:
	_plugin.load_interstitial(MAX_interstitial_ad_id)

func show_interstitial() -> void:
	_plugin.show_interstitial()

func is_interstitila_ad_ready() -> bool:
	return _plugin.get_is_interstitial_ad_ready()
