class_name MAXAdView
extends MaxSingletonBridge

static var _plugin := _get_plugin("MaxBannerAd")

var MAX_banner_ad_id : String = ""
var MAX_banner_ad_position : int = 1

func _init(ad_unit_id : String, adview_listener: MAXAdviewListener, ad_position : int) -> void:
	MAX_banner_ad_id = ad_unit_id
	MAX_banner_ad_position = ad_position
	_plugin.connect("banner_ad_loaded", func():	adview_listener.banner_ad_loaded.call_deferred())
	_plugin.connect("banner_ad_load_failed", func(error: String):	adview_listener.banner_ad_load_failed.call_deferred(error))
	_plugin.connect("banner_ad_displayed", func():	adview_listener.banner_ad_displayed.call_deferred())
	_plugin.connect("banner_ad_display_failed", func(error: String):	adview_listener.banner_ad_display_failed.call_deferred(error))
	_plugin.connect("banner_ad_expanded", func():	adview_listener.banner_ad_expanded.call_deferred())
	_plugin.connect("banner_ad_clicked", func():	adview_listener.banner_ad_clicked.call_deferred())
	_plugin.connect("banner_ad_collapsed", func():	adview_listener.banner_ad_collapsed.call_deferred())
	_plugin.connect("banner_ad_hidden", func():	adview_listener.banner_ad_hidden.call_deferred())
	load_banner()

#Automatically Displays
func load_banner() -> void:
	_plugin.load_banner(MAX_banner_ad_id, MAX_banner_ad_position)

func destroy_banner() -> void:
	_plugin.destroy_banner()

func stop_banner_auto_refresh() -> void:
	_plugin.stop_banner_auto_refresh()

func start_banner_auto_refresh() -> void:
	_plugin.start_banner_auto_refresh()

func get_is_banner_auto_refresh() -> bool:
	return _plugin.get_banner_auto_refresh_status()
