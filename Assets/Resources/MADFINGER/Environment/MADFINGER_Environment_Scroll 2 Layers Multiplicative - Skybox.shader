Shader "MADFINGER/Environment/Scroll 2 Layers Multiplicative - Skybox"
{
  Properties
  {
    _MainTex ("Base layer (RGB)", 2D) = "white" {}
    _DetailTex ("2nd layer (RGB)", 2D) = "white" {}
    _ScrollX ("Base layer Scroll speed X", float) = 1
    _ScrollY ("Base layer Scroll speed Y", float) = 0
    _Scroll2X ("2nd layer Scroll speed X", float) = 1
    _Scroll2Y ("2nd layer Scroll speed Y", float) = 0
    _AMultiplier ("Layer Multiplier", float) = 0.5
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "Geometry+10"
      "RenderType" = "Opaque"
    }
    LOD 100
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "QUEUE" = "Geometry+10"
        "RenderType" = "Opaque"
      }
      LOD 100
      ZWrite Off
      Fog
      { 
        Mode  Off
      } 
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
      uniform float _AMultiplier;
      uniform sampler2D _MainTex;
      uniform sampler2D _DetailTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          u_xlat1 = (_Time.xyxy * float4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y));
          u_xlat1 = frac(u_xlat1);
          out_v.texcoord.xy = (u_xlat0.xy + u_xlat1.xy);
          u_xlat0.xy = TRANSFORM_TEX(in_v.texcoord.xy, _DetailTex);
          out_v.texcoord1.xy = (u_xlat1.zw + u_xlat0.xy);
          out_v.texcoord2 = float4(_AMultiplier, _AMultiplier, _AMultiplier, _AMultiplier);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      float4 u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_1 = tex2D(_DetailTex, in_f.texcoord1.xy);
          u_xlat16_0 = (u_xlat16_0 * u_xlat16_1);
          out_f.color = (u_xlat16_0 * in_f.texcoord2);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
