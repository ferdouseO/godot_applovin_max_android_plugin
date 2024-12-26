extends Control

@onready var test_log := $CenterContainer/VBoxContainer/TestLog
@onready var init_btn := $CenterContainer/VBoxContainer/InitializeMax
@onready var int_btn := $CenterContainer/VBoxContainer/HBoxContainer2/InterstitialBtn
@onready var rew_btn := $CenterContainer/VBoxContainer/HBoxContainer2/RewardedBtn
@onready var banner_btn := $CenterContainer/VBoxContainer/HBoxContainer2/BannerBtn
@onready var load_banner_btn := $CenterContainer/VBoxContainer/HBoxContainer5/LoadBanner
@onready var app_open_btn := $CenterContainer/VBoxContainer/HBoxContainer3/AppOpenBtn
@onready var mrec_btn := $CenterContainer/VBoxContainer/HBoxContainer3/MRECBtn
@onready var native_btn := $CenterContainer/VBoxContainer/HBoxContainer3/NativeBtn
@onready var mediation_debugger_btn := $CenterContainer/VBoxContainer/MediationDebugger
@onready var main_container := $CenterContainer/VBoxContainer
@onready var banner_btn_container := $CenterContainer/VBoxContainer/HBoxContainer5
@onready var congratulations := $CenterContainer/VBoxContainer/Congratulations
@onready var banner_auto_refresh_btn := $CenterContainer/VBoxContainer/HBoxContainer5/BannerAutoRefreshBtn


const APPLOVIN_SDK_KEY : String = ""
const REWARDED_AD_ID : String = ""
const INTERSTITIAL_AD_ID : String = ""
const BANNER_AD_ID : String = ""


var interstitial_loaded : bool = false
var rewarded_loaded : bool = false
var banner_loaded : bool = false

var current_banner_position : int = MAXBannerPosition.BOTTOM

var max_initializer : MAXInitializer
var max_adview : MAXAdView
var max_rewarded_ad : MAXRewardrd
var max_interstitial_ad : MAXInterstitial

var max_initialization_listener : MAXInitializationListener = MAXInitializationListener.new()
var max_adview_listener : MAXAdviewListener = MAXAdviewListener.new()
var max_rewarded_listener : MAXRewardedListener = MAXRewardedListener.new()
var max_interstitial_listener : MAXInterstitialListener = MAXInterstitialListener.new()

func _ready():
	if OS.get_name() != "Android":
		log_error("Platform Mismatch! Currently This Plugin supports Andrid Only!")
		return
	if Engine.has_singleton("ApplovinMax"):
		max_initialization_listener.applovin_initialized = _on_ApplovinMax_applovin_initialized
		
		max_interstitial_listener.interstitial_ad_loaded = _on_ApplovinMax_interstitial_ad_loaded
		max_interstitial_listener.interstitial_ad_closed = _on_ApplovinMax_interstitial_ad_closed
		max_interstitial_listener.interstitial_ad_load_failed = _on_ApplovinMax_interstitial_ad_load_failed
		max_interstitial_listener.interstitial_ad_displayed = _on_ApplovinMax_interstitial_ad_displayed
		max_interstitial_listener.interstitial_ad_display_failed = _on_ApplovinMax_interstitial_ad_display_failed
		max_interstitial_listener.interstitial_ad_clicked = _on_ApplovinMax_interstitial_ad_clicked
		max_interstitial_listener.interstitial_ad_not_ready = _on_ApplovinMax_interstitial_ad_not_ready
		
		max_rewarded_listener.rewarded_ad_loaded = _on_ApplovinMax_rewarded_ad_loaded
		max_rewarded_listener.rewarded_ad_load_failed = _on_ApplovinMax_rewarded_ad_load_failed
		max_rewarded_listener.rewarded_ad_displayed = _on_ApplovinMax_rewarded_ad_displayed
		max_rewarded_listener.rewarded_ad_display_failed = _on_ApplovinMax_rewarded_ad_display_failed
		max_rewarded_listener.user_earned_reward = _on_ApplovinMax_user_earned_reward
		max_rewarded_listener.rewarded_ad_closed = _on_ApplovinMax_rewarded_ad_closed
		max_rewarded_listener.rewarded_ad_clicked = _on_ApplovinMax_rewarded_ad_clicked
		max_rewarded_listener.rewarded_ad_not_ready = _on_ApplovinMax_rewarded_ad_not_ready
		
		max_adview_listener.banner_ad_loaded = _on_ApplovinMax_banner_ad_loaded
		max_adview_listener.banner_ad_load_failed = _on_ApplovinMax_banner_ad_load_failed
		max_adview_listener.banner_ad_displayed = _on_ApplovinMax_banner_ad_displayed
		max_adview_listener.banner_ad_display_failed = _on_ApplovinMax_banner_ad_display_failed
		max_adview_listener.banner_ad_clicked = _on_ApplovinMax_banner_ad_clicked
		max_adview_listener.banner_ad_expanded = _on_ApplovinMax_banner_ad_expanded
		max_adview_listener.banner_ad_collapsed = _on_ApplovinMax_banner_ad_collapsed
		max_adview_listener.banner_ad_hidden = _on_ApplovinMax_banner_ad_hidden
		log_text("Applovin MAX plugin found!")
		init_btn.disabled = false
	else:
		log_error("Applovin MAX plugin not found!")
		printerr("plugin not found!")
		
	
	#if Engine.has_singleton("MaxBannerAd"):
		#var bnr = Engine.get_singleton("MaxBannerAd")
		#print("UraDhura: " +str(bnr.p()))


func log_text(text: String) -> void:
	test_log.text += text +"\n"
	print(text)

func log_error(text : String) -> void:
	test_log.text += "[color=red]" +text +"[/color]" +"\n"
	printerr(text)





func _on_ApplovinMax_applovin_initialized() -> void:
	log_text("Applovin MAX initialization successfull!")
	congratulations.show()
	init_btn.hide()
	mediation_debugger_btn.show()
	int_btn.disabled = false
	rew_btn.disabled = false
	banner_btn.disabled = false
	app_open_btn.disabled = false
	mrec_btn.disabled = false
	native_btn.disabled = false
	mediation_debugger_btn.disabled = false







func _on_ApplovinMax_interstitial_ad_loaded() -> void:
	log_text("Interstitial ad loaded.")
	int_btn.text = "Show Interstitial"
	int_btn.disabled = false

func _on_ApplovinMax_interstitial_ad_displayed() -> void:
	log_text("Interstitial ad Displayed.")

func _on_ApplovinMax_interstitial_ad_closed() -> void:
	log_text("Interstitial ad closed.")
	await get_tree().create_timer(0.5).timeout
	int_btn.text = "Load Interstitial"
	int_btn.disabled = false
	#log_text("Automatically loading the next Interstitial ad.")

func _on_ApplovinMax_interstitial_ad_load_failed(retry_attempt_count: int) -> void:
	log_error("Interstitial ad load failed! Auto Retry Attempt: %d" %retry_attempt_count)

func _on_ApplovinMax_interstitial_ad_display_failed() -> void:
	log_error("Interstitial ad Display failed!")

func _on_ApplovinMax_interstitial_ad_clicked() -> void:
	log_text("Interstitial ad Clicked")

func _on_ApplovinMax_interstitial_ad_not_ready() -> void:
	log_error("Interstitial ad not ready!")








func _on_ApplovinMax_rewarded_ad_loaded() -> void:
	log_text("Rewarded ad loaded.")
	rewarded_loaded = true
	rew_btn.text = "Show Rewarded"
	rew_btn.disabled = false

func _on_ApplovinMax_rewarded_ad_load_failed() -> void:
	log_error("Rewarded ad load failed!")
	rew_btn.disabled = false

func _on_ApplovinMax_rewarded_ad_displayed() -> void:
	log_text("Rewarded ad displayed.")

func _on_ApplovinMax_rewarded_ad_display_failed() -> void:
	log_error("Rewarded ad display failed!")

func _on_ApplovinMax_user_earned_reward(reward: String, amount: int) -> void:
	log_text("User earned reward: %s, amount: %d" %[reward, amount])

func _on_ApplovinMax_rewarded_ad_closed() -> void:
	log_text("Rewarded ad closed.")
	rewarded_loaded = false
	rew_btn.text = "Load Rewarded"
	rew_btn.disabled = false

func _on_ApplovinMax_rewarded_ad_clicked() -> void:
	log_text("Rewarded ad clicked.")

func _on_ApplovinMax_rewarded_ad_not_ready() -> void:
	log_error("Rewarded ad not ready!")








func _on_ApplovinMax_banner_ad_loaded() -> void:
	log_text("Banner ad loaded.")
	banner_loaded = true
	banner_btn.disabled = false
	load_banner_btn.text = "Destroy Banner"

func _on_ApplovinMax_banner_ad_load_failed(error: String) -> void:
	log_error("Banner ad load failed! - " +error)
	banner_btn.disabled = false

func _on_ApplovinMax_banner_ad_displayed() -> void:
	log_text("Banner ad displayed.")
	banner_auto_refresh_btn.text = "Stop Banner Auto Refresh"
	banner_auto_refresh_btn.disabled = false

func _on_ApplovinMax_banner_ad_display_failed(error: String) -> void:
	log_error("Banner ad display failed! - " +error)
	banner_btn.disabled = false

func _on_ApplovinMax_banner_ad_clicked() -> void:
	log_text("Banner ad clicked.")

func _on_ApplovinMax_banner_ad_hidden() -> void:
	log_text("Banner ad hidden.")

func _on_ApplovinMax_banner_ad_expanded() -> void:
	log_text("Banner ad expanded.")

func _on_ApplovinMax_banner_ad_collapsed() -> void:
	log_text("Banner ad collapsed.")
	banner_loaded = false
	load_banner_btn.text = "Load Banner"
	banner_btn.disabled = false
	banner_btn_container.hide()


func _on_initialize_max_pressed() -> void:
	init_btn.disabled = true
	log_text("Initializing Applovin MAX...")
	max_initializer = MAXInitializer.new(APPLOVIN_SDK_KEY, max_initialization_listener)
	max_initializer.initialize_applovin_max()


func _on_interstitial_btn_pressed() -> void:
	int_btn.disabled = true
	if not max_interstitial_ad:
		max_interstitial_ad = MAXInterstitial.new(INTERSTITIAL_AD_ID, max_interstitial_listener)
		max_interstitial_ad.load_interstitial()
		log_text("Loading Interstitial...")
	else:
		if max_interstitial_ad.is_interstitila_ad_ready():
			max_interstitial_ad.show_interstitial()
		else:
			max_interstitial_ad.load_interstitial()
			log_text("Loading Interstitial...")


func _on_rewarded_btn_pressed() -> void:
	rew_btn.disabled = true
	if not max_rewarded_ad:
		max_rewarded_ad = MAXRewardrd.new(REWARDED_AD_ID, max_rewarded_listener)
		max_rewarded_ad.load_rewarded()
		log_text("Loading Rewarded...")
	else:
		if max_rewarded_ad.is_rewarded_ad_ready():
			max_rewarded_ad.show_rewarded()
		else:
			max_rewarded_ad.load_rewarded()
			log_text("Loading Rewarded...")


func _on_banner_btn_pressed() -> void:
	banner_btn_container.visible = not banner_btn_container.visible


func _on_app_open_btn_pressed() -> void:
	log_error("App Open Ad is not supported yet! Will be added soon.")


func _on_mrec_btn_pressed() -> void:
	log_error("MREC ad is not supported yet! Will be added soon.")


func _on_native_btn_pressed() -> void:
	log_error("Native Ad is not supported yet! Will be added soon.")


func _on_mediation_debugger_pressed() -> void:
	max_initializer.display_mediation_debugger()








func _on_load_banner_pressed() -> void:
	banner_btn.disabled = true
	if load_banner_btn.text == "Load Banner":
		if max_adview:
			max_adview.stop_banner_auto_refresh()
			await get_tree().create_timer(0.5).timeout
			max_adview.destroy_banner()
			max_adview = null
		max_adview = MAXAdView.new(BANNER_AD_ID, max_adview_listener, current_banner_position)
		log_text("Loading Banner ad. Position: " +str(current_banner_position))
	else:
		max_adview.stop_banner_auto_refresh()
		await get_tree().create_timer(1.5).timeout
		max_adview.destroy_banner()
		max_adview = null

func _on_banner_top_pressed():
	current_banner_position = MAXBannerPosition.TOP
	load_banner_btn.disabled = false
	#print(banner_position)


func _on_banner_bottom_pressed():
	current_banner_position = MAXBannerPosition.BOTTOM
	load_banner_btn.disabled = false


func _on_banner_left_pressed():
	log_error("MAX Banner ad on LEFT side is not supported yet!")
	#current_banner_position = MAXBannerPosition.LEFT
	#max_plugin.switch_banner_position(banner_position.LEFT)


func _on_banner_right_pressed():
		log_error("MAX Banner ad on RIGHT side is not supported yet!")
	#current_banner_position = MAXBannerPosition.RIGHT
	#max_plugin.switch_banner_position(banner_position.RIGHT)


func _on_banner_auto_refresh_btn_pressed() -> void:
	banner_auto_refresh_btn.disabled = true
	if max_adview.get_is_banner_auto_refresh():
		max_adview.stop_banner_auto_refresh()
		banner_auto_refresh_btn.text = "Start Banner Auto Refresh"
		log_text("Banner ad auto refresh stoped!")
	else:
		max_adview.start_banner_auto_refresh()
		banner_auto_refresh_btn.text = "Stop Banner Auto Refresh"
		log_text("Banner ad auto refresh started!")
	await get_tree().create_timer(2).timeout
	banner_auto_refresh_btn.disabled = false



func _on_coffee_btn_pressed():
	OS.shell_open("https://buymeacoffee.com/ferdouse_o")
