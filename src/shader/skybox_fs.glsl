// ------------------------------------------------------------------
// OUTPUTS  ---------------------------------------------------------
// ------------------------------------------------------------------

out vec4 FS_OUT_Color;

// ------------------------------------------------------------------
// INPUTS  ----------------------------------------------------------
// ------------------------------------------------------------------

in vec3 FS_IN_TexCoord;

// ------------------------------------------------------------------
// UNIFORMS  --------------------------------------------------------
// ------------------------------------------------------------------

uniform samplerCube s_Skybox;

// ------------------------------------------------------------------
// FUNCTIONS  -------------------------------------------------------
// ------------------------------------------------------------------

vec3 linear_to_srgb(in vec3 color)
{
    vec3 x = color * 12.92;
    vec3 y = 1.055 * pow(clamp(color, 0.0, 1.0), vec3(1.0 / 2.4)) - 0.055;

    vec3 clr = color;
    clr.r = color.r < 0.0031308 ? x.r : y.r;
    clr.g = color.g < 0.0031308 ? x.g : y.g;
    clr.b = color.b < 0.0031308 ? x.b : y.b;

    return clr;
}

// ------------------------------------------------------------------

vec3 exposed_color(vec3 color)
{
	float exposure = -16.0;
	return exp2(exposure) * color;
}

// ------------------------------------------------------------------
// MAIN  ------------------------------------------------------------
// ------------------------------------------------------------------

void main()
{
	vec3 color =  exposed_color(texture(s_Skybox, normalize(FS_IN_TexCoord)).rgb);
	FS_OUT_Color = vec4(linear_to_srgb(color), 1.0);
}

// ------------------------------------------------------------------