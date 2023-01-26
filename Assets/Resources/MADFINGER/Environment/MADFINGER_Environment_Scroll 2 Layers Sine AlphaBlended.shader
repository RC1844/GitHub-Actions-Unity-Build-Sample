Shader "MADFINGER/Environment/Scroll 2 Layers Sine AlphaBlended"
{
  Properties
  {
    _MainTex ("Base layer (RGB)", 2D) = "white" {}
    _DetailTex ("2nd layer (RGB)", 2D) = "white" {}
    _ScrollX ("Base layer Scroll speed X", float) = 1
    _ScrollY ("Base layer Scroll speed Y", float) = 0
    _Scroll2X ("2nd layer Scroll speed X", float) = 1
    _Scroll2Y ("2nd layer Scroll speed Y", float) = 0
    _SineAmplX ("Base layer sine amplitude X", float) = 0.5
    _SineAmplY ("Base layer sine amplitude Y", float) = 0.5
    _SineFreqX ("Base layer sine freq X", float) = 10
    _SineFreqY ("Base layer sine freq Y", float) = 10
    _SineAmplX2 ("2nd layer sine amplitude X", float) = 0.5
    _SineAmplY2 ("2nd layer sine amplitude Y", float) = 0.5
    _SineFreqX2 ("2nd layer sine freq X", float) = 10
    _SineFreqY2 ("2nd layer sine freq Y", float) = 10
    _Color ("Color", Color) = (1,1,1,1)
    _MMultiplier ("Layer Multiplier", float) = 2
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    LOD 100
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 100
      ZWrite Off
      Cull Off
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile LIGHTMAP_OFF
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4 _DetailTex_ST;
      uniform float _ScrollX;
      uniform float _ScrollY;
      uniform float _Scroll2X;
      uniform float _Scroll2Y;
      uniform float _MMultiplier;
      uniform float _SineAmplX;
      uniform float _SineAmplY;
      uniform float _SineFreqX;
      uniform float _SineFreqY;
      uniform float _SineAmplX2;
      uniform float _SineAmplY2;
      uniform float _SineFreqX2;
      uniform float _SineFreqY2;
      uniform float4 _Color;
      uniform sampler2D _MainTex;
      uniform sampler2D _DetailTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 texcoord :TEXCOORD0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float3 u_xlat2;
      float u_xlat6;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0.x = (_Time.x * _SineFreqX);
          u_xlat0.x = sin(u_xlat0.x);
          u_xlat2.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          u_xlat1 = (_Time.xyxy * float4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y));
          u_xlat1 = frac(u_xlat1);
          u_xlat2.xy = (u_xlat2.xy + u_xlat1.xy);
          out_v.texcoord.x = ((u_xlat0.x * _SineAmplX) + u_xlat2.x);
          u_xlat0.xy = TRANSFORM_TEX(in_v.texcoord.xy, _DetailTex);
          u_xlat0.xy = (u_xlat1.zw + u_xlat0.xy);
          u_xlat6 = (_Time.x * _SineFreqY2);
          u_xlat6 = sin(u_xlat6);
          out_v.texcoord.w = ((u_xlat6 * _SineAmplY2) + u_xlat0.y);
          u_xlat2.xz = (_Time.xx * float2(_SineFreqY, _SineFreqX2));
          u_xlat2.xz = sin(u_xlat2.xz);
          out_v.texcoord.y = ((u_xlat2.x * _SineAmplY) + u_xlat2.y);
          out_v.texcoord.z = ((u_xlat2.z * _SineAmplX2) + u_xlat0.x);
          u_xlat0 = (float4(_MMultiplier, _MMultiplier, _MMultiplier, _MMultiplier) * _Color);
          u_xlat0 = (u_xlat0 * in_v.color);
          out_v.texcoord1 = u_xlat0;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      float4 u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_1 = tex2D(_DetailTex, in_f.texcoord.zw);
          u_xlat16_0 = (u_xlat16_0 * u_xlat16_1);
          out_f.color = (u_xlat16_0 * in_f.texcoord1);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
