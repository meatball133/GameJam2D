wget "https://github.com/godotengine/godot-builds/releases/download/4.3-dev6/Godot_v4.3-dev6_mono_linux_x86_64.zip"
unzip Godot_v4.3-dev6_mono_linux_x86_64.zip
mv Godot_v4.3-dev6_mono_linux_x86_64/Godot_v4.3-dev6_mono_linux_x86_64 ./godot
./godot --export-release 1 ./export