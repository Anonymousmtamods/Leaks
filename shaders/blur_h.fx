// Blur Gaussiano Horizontal (separável)
// vine_core blur system

texture gTexture;
float gBlurSize = 0.003;

sampler2D Sampler0 = sampler_state {
    Texture = (gTexture);
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU = Clamp;
    AddressV = Clamp;
};

float4 PS_BlurH(float2 uv : TEXCOORD0) : COLOR0 {
    float4 color = float4(0, 0, 0, 0);

    // Kernel gaussiano 9-tap horizontal
    color += tex2D(Sampler0, uv + float2(-4.0 * gBlurSize, 0)) * 0.0162;
    color += tex2D(Sampler0, uv + float2(-3.0 * gBlurSize, 0)) * 0.0540;
    color += tex2D(Sampler0, uv + float2(-2.0 * gBlurSize, 0)) * 0.1218;
    color += tex2D(Sampler0, uv + float2(-1.0 * gBlurSize, 0)) * 0.1944;
    color += tex2D(Sampler0, uv)                                 * 0.2270;
    color += tex2D(Sampler0, uv + float2( 1.0 * gBlurSize, 0)) * 0.1944;
    color += tex2D(Sampler0, uv + float2( 2.0 * gBlurSize, 0)) * 0.1218;
    color += tex2D(Sampler0, uv + float2( 3.0 * gBlurSize, 0)) * 0.0540;
    color += tex2D(Sampler0, uv + float2( 4.0 * gBlurSize, 0)) * 0.0162;

    return color;
}

technique BlurHorizontal {
    pass P0 {
        PixelShader = compile ps_2_0 PS_BlurH();
    }
}
