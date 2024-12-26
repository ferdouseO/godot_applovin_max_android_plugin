class_name MAXAdviewListener


var banner_ad_loaded : Callable = func(): pass
var banner_ad_load_failed : Callable = func(error: String): pass
var banner_ad_displayed : Callable = func(): pass
var banner_ad_display_failed : Callable = func(error: String): pass
var banner_ad_expanded : Callable = func(): pass
var banner_ad_collapsed : Callable = func(): pass
var banner_ad_clicked : Callable = func(): pass
var banner_ad_hidden : Callable = func(): pass
