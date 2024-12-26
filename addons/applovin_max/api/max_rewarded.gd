class_name MAXRewardrd
extends MaxSingletonBridge

static var _plugin := _get_plugin("MaxRewarded")

var MAX_rewarded_ad_id : String = ""


func _init(ad_unit_id : String, reward_listener: MAXRewardedListener) -> void:
	MAX_rewarded_ad_id = ad_unit_id
	_plugin.connect("rewarded_ad_loaded", func():	reward_listener.rewarded_ad_loaded.call_deferred())
	_plugin.connect("rewarded_ad_load_failed", func(error: String):	reward_listener.rewarded_ad_load_failed.call_deferred(error))
	_plugin.connect("rewarded_ad_displayed", func():	reward_listener.rewarded_ad_displayed.call_deferred())
	_plugin.connect("rewarded_ad_display_failed", func(error: String):	reward_listener.rewarded_ad_display_failed.call_deferred(error))
	_plugin.connect("user_earned_reward", func():	reward_listener.user_earned_reward.call_deferred())
	_plugin.connect("rewarded_ad_closed", func():	reward_listener.rewarded_ad_closed.call_deferred())
	_plugin.connect("rewarded_ad_clicked", func():	reward_listener.rewarded_ad_clicked.call_deferred())
	_plugin.connect("rewarded_ad_not_ready", func():	reward_listener.rewarded_ad_not_ready.call_deferred())


func load_rewarded() -> void:
	_plugin.load_rewarded(MAX_rewarded_ad_id)

func show_rewarded() -> void:
	_plugin.show_rewarded()

func is_rewarded_ad_ready() -> bool:
	return _plugin.get_is_rewarded_ad_ready()
