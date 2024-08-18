shader_type canvas_item;

uniform float aspect = 1.0;
uniform float radius = 1.07;
uniform float alpha : hint_range(0.0, 1.0, 0.1) = 1.0;
uniform float crop = 0.943;
uniform vec4 crop_color : source_color = vec4(0,0,0,1);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float crop_feathering = 0.1;

const float base_distortion = 0.99; 
uniform float channel_offset : hint_range(-0.1, 0.1, 0.001) = 0.005; 
uniform float noise_strength = 5.0;

void fragment()
{
    vec2 xy = (SCREEN_UV * 2.0 - 1.0); 
    xy = vec2(xy.x * aspect, xy.y); 
    float d = length(xy);
    vec4 tex;
    if (d < radius)
    {
        // Use the original UV coordinates without any distortion
        vec2 uv_r = SCREEN_UV + vec2(0.0 * channel_offset, 0.0); 
        vec2 uv_g = SCREEN_UV + vec2(1.0 * channel_offset, 0.0); 
        vec2 uv_b = SCREEN_UV + vec2(2.0 * channel_offset, 0.0); 
        
        tex.r = texture(SCREEN_TEXTURE, uv_r).r;
        tex.g = texture(SCREEN_TEXTURE, uv_g).g;
        tex.b = texture(SCREEN_TEXTURE, uv_b).b;

        // Adding noise
        float x = (UV.x + 4.0) * (UV.y + 4.0) * (TIME * 10.0);
        tex += vec4(mod((mod(x, 13.0)) * (mod(x, 123.0)), 0.01) - 0.005) * noise_strength;

        COLOR = tex;
        COLOR.a = alpha;
    }

    if (d > crop)
    {
        float softness = smoothstep(crop, crop + crop_feathering, d);
        COLOR = mix(tex, crop_color, softness);
        COLOR.a = alpha;
    }
}
