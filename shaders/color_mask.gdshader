shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform bool inverted;

const vec4 dark_color = vec4(0.051, 0.122, 0.151, 1);
const vec4 light_color = vec4(0.259, 0.51, 0.541, 1);

void fragment() {
	vec4 original_color = texture(screen_texture, SCREEN_UV);
	
	if ((original_color == vec4(0, 0, 0, 1) && !inverted) || (original_color == vec4(1, 1, 1, 0) && inverted)) {
		COLOR = light_color;
	} else {
		COLOR = dark_color;
	}
}
