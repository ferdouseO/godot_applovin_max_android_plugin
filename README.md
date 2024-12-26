# godot_applovin_max_android_plugin
Applovin MAX android Plugin for the Godot game engine 4.2.2, 4.3+with full mediation support.
# Installation
## Godot Asset Library (recommended)
## Manual
1. Clone the repo
2. Copy the "applovin_max" folder "addons" folder to your projects "addons" folder.
# How to use
1. Enable the plugin in your godot "Project Settings > Plugins"
2. Install Android Build Template
3. Copy the "applovinmax.aar" archive to "project > android > build > libs > debug" for debug and to "project > android > build > libs > release" for release build
4. Add "implementation 'com.applovin:applovin-sdk:+'" in the dependency section of your "project > android > build > build.gradle" file
5. Add the applovin max mediation adapters in the dependency section of your "project > android > build > build.gradle" file
6. There is an example scene in the "addons > applovin_max > example" folder
7. Add your applovin SDK key and ad unit ids
8. Go to "Project > Export" in the godot editor, add a Android(Runnable) preset and enable "Use Gradle Build"
9. Add your project's package name (the one you used in Apploven) in the export preset and 
10. Connect an android device and build.

