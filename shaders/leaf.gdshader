shader_type canvas_item;

uniform float sway_strength = 0.1;
uniform float sway_speed = 1.0;
uniform float sway_speed_diff = 0.25;

void fragment() {
    vec2 uv = UV;
    uv.x += sway_strength * sin(TIME * sway_speed + uv.y) * (1.0 - uv.y);
    uv.y += sway_strength * sin(TIME * (sway_speed + sway_speed_diff) + uv.x) * (1.0 - uv.y);
    COLOR = texture(TEXTURE, uv);
    COLOR.rb -= 0.05;
}

//void light() {
    // Called for every pixel for every light affecting the CanvasItem.
    // Uncomment to replace the default light processing function with this one.
//}
