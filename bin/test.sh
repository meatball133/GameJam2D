wget "https://github.com/godotengine/godot-builds/releases/download/4.3-dev6/Godot_v4.3-dev6_mono_linux_x86_64.zip"
unzip Godot_v4.3-dev6_mono_linux_x86_64.zip
wget "https://github.com/godotengine/godot-builds/releases/download/4.3-dev6/Godot_v4.3-dev6_mono_export_templates.tpz"
unzip Godot_v4.3-dev6_mono_export_templates.tpz
mkdir "/godot/export_templates/4.3.dev6.mono/"
mv templates /home/runner/.local/share/godot/export_templates/4.3.dev6.mono/

./Godot_v4.3-dev6_mono_linux_x86_64/Godot_v4.3-dev6_mono_linux.x86_64 --headless --export-release Linux ./export