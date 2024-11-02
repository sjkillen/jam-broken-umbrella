shader_type spatial;

uniform vec3 color : source_color;
uniform float alpha;
uniform float specular;

void fragment() {
	ALBEDO = color;
	ALPHA = alpha;
	SPECULAR = specular;
}
