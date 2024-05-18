shader_type canvas_item;

uniform float fill:hint_range(0.0,1.0) = 0.0; 
uniform vec3 fill_color : source_color = vec3(1.0);
uniform vec3 base_color : source_color = vec3(1.0);

void fragment() {
	COLOR.rgb = fill_color*step(UV.x-fill,.001)+base_color*step(fill-UV.x,0.001);
}

