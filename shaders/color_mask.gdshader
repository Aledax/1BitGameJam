shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	vec4 original_color = texture(screen_texture, SCREEN_UV);
	
	if (original_color == vec4(0, 0, 0, 1)) {
		COLOR = vec4(0.259, 0.51, 0.541, 1);
	} else {
		COLOR = vec4(0.051, 0.122, 0.141, 1);
	}
}
