Shader "FXMaker/Mask Alpha Blended Tint"
{
  Properties
  {
    _TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
    _MainTex ("Particle Texture", 2D) = "white" {}
    _Mask ("Mask", 2D) = "white" {}
    [HideInInspector] _Stencil ("_Stencil", float) = 0
    [HideInInspector] _StencilOp ("_StencilOp", float) = 0
    [HideInInspector] _StencilComp ("_StencilComp", float) = 0
    [HideInInspector] _StencilReadMask ("_StencilReadMask", float) = 0
    [HideInInspector] _StencilWriteMask ("_StencilWriteMask", float) = 0
    [HideInInspector] _ColorMask ("_ColorMask", float) = 0
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Fog
      { 
        Mode  Off
      } 
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4 _Mask_ST;
      uniform float4 _TintColor;
      uniform sampler2D _MainTex;
      uniform sampler2D _Mask;
      struct appdata_t
      {
          float3 vertex :POSITION0;
          float4 color :COLOR0;
          float3 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float2 texcoord2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord1 :TEXCOORD1;
          float2 texcoord2 :TEXCOORD2;
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
          out_v.color = in_v.color;
          #ifdef UNITY_ADRENO_ES3
          out_v.color = min(max(out_v.color, 0), 1);
          #else
          out_v.color = clamp(out_v.color, 0, 1);
          #endif
          out_v.texcoord1.xy = TRANSFORM_TEX(in_v.texcoord.xy, _Mask);
          u_xlat0.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.texcoord.xy = u_xlat0.xy;
          out_v.texcoord2.xy = u_xlat0.xy;
          out_v.vertex = UnityObjectToClipPos(float4(in_v.vertex, 0));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      float4 u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = (in_f.color * _TintColor);
          u_xlat16_1 = tex2D(_Mask, in_f.texcoord1.xy);
          u_xlat16_0 = (u_xlat16_0 * u_xlat16_1);
          u_xlat16_1 = tex2D(_MainTex, in_f.texcoord2.xy);
          u_xlat16_0 = (u_xlat16_0 * u_xlat16_1);
          out_f.color = (u_xlat16_0 + u_xlat16_0);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Fog
      { 
        Mode  Off
      } 
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _Mask_ST;
      uniform float4 _MainTex_ST;
      uniform sampler2D _Mask;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float3 vertex :POSITION0;
          float4 color :COLOR0;
          float3 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
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
          out_v.color = in_v.color;
          #ifdef UNITY_ADRENO_ES3
          out_v.color = min(max(out_v.color, 0), 1);
          #else
          out_v.color = clamp(out_v.color, 0, 1);
          #endif
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _Mask);
          out_v.texcoord1.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.vertex = UnityObjectToClipPos(float4(in_v.vertex, 0));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      float4 u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_Mask, in_f.texcoord.xy);
          u_xlat16_0 = (u_xlat16_0 * in_f.color);
          u_xlat16_1 = tex2D(_MainTex, in_f.texcoord1.xy);
          out_f.color = (u_xlat16_0 * u_xlat16_1);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
