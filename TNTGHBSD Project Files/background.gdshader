shader_type canvas_item;

vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
	float cosa = cos(rotation);
	float sina = sin(rotation);
	uv -= pivot;
	return vec2(
		cosa * uv.x - sina * uv.y,
		cosa * uv.y + sina * uv.x 
	) + pivot;
}

void fragment() {
	COLOR = vec4(rotateUV(UV,vec2(0,0),cos(TIME)+sin(TIME)), cos(TIME), 1.0);
	COLOR.x *= sin(TIME)+COLOR.y+COLOR.x;
	COLOR.y *= cos(TIME)+COLOR.x+COLOR.y;
	COLOR *= .75;
}
