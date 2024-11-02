shader_type canvas_item;

uniform sampler2D screen : hint_screen_texture;
uniform sampler2D fade : source_color;

void fragment() {
	vec3 color = texture(screen, SCREEN_UV).rgb;
	COLOR.rgb = mix(vec3(0.0), color, texture(fade, vec2(SCREEN_UV.x + SCREEN_UV.y)*.5).r);
}
