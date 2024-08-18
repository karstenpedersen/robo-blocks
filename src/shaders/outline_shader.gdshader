shader_type spatial;
render_mode cull_front, unshaded;  // Use cull_front to only draw back faces

uniform vec4 outline_color : source_color;
uniform float outline_width = 0.05;  // Control the width of the outline

void vertex() {
    // Scale the vertices outward slightly
    VERTEX *= 1.0 + outline_width;

    // Apply transformations
    vec4 clip_position = PROJECTION_MATRIX * (MODELVIEW_MATRIX * vec4(VERTEX, 1.0));
    POSITION = clip_position;
}

void fragment() {
    // Set the outline color
    ALBEDO = outline_color.rgb;
    ALPHA = outline_color.a;
}
