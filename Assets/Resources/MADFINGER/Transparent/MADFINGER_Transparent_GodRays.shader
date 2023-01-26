Shader "MADFINGER/Transparent/GodRays"
{
  Properties
  {
    _MainTex ("Base texture", 2D) = "white" {}
    _FadeOutDistNear ("Near fadeout dist", float) = 10
    _FadeOutDistFar ("Far fadeout dist", float) = 10000
    _Multiplier ("Multiplier", float) = 1
    _ContractionAmount ("Near contraction amount", float) = 5
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
      Blend One One
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float _FadeOutDistNear;
      uniform float _FadeOutDistFar;
      uniform float _Multiplier;
      uniform float _ContractionAmount;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 texcoord :TEXCOORD0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float u_xlat2;
      float u_xlat4;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.xyz = mul(unity_MatrixV, unity_ObjectToWorld[0]);
          u_xlat0.xyz = (u_xlat0.xyz * in_v.vertex.yyy);
          u_xlat1.xyz = mul(unity_MatrixV, unity_ObjectToWorld[0]);
          u_xlat0.xyz = ((u_xlat1.xyz * in_v.vertex.xxx) + u_xlat0.xyz);
          u_xlat1.xyz = mul(unity_MatrixV, unity_ObjectToWorld[0]);
          u_xlat0.xyz = ((u_xlat1.xyz * in_v.vertex.zzz) + u_xlat0.xyz);
          u_xlat1.xyz = mul(unity_MatrixV, unity_ObjectToWorld[0]);
          u_xlat0.xyz = ((u_xlat1.xyz * in_v.vertex.www) + u_xlat0.xyz);
          u_xlat0.x = length(u_xlat0.xyz);
          u_xlat2 = (u_xlat0.x + (-_FadeOutDistFar));
          u_xlat0.x = (u_xlat0.x / _FadeOutDistNear);
          #ifdef UNITY_ADRENO_ES3
          u_xlat0.x = min(max(u_xlat0.x, 0), 1);
          #else
          u_xlat0.x = clamp(u_xlat0.x, 0, 1);
          #endif
          u_xlat0.x = (u_xlat0.x * u_xlat0.x);
          u_xlat2 = max(u_xlat2, 0);
          u_xlat2 = (u_xlat2 * 0.200000003);
          u_xlat2 = min(u_xlat2, 1);
          u_xlat0.y = ((-u_xlat2) + 1);
          u_xlat0.xy = (u_xlat0.xy * u_xlat0.xy);
          u_xlat4 = (((-u_xlat0.x) * u_xlat0.y) + 1);
          u_xlat0.x = (u_xlat0.y * u_xlat0.x);
          u_xlat1 = (u_xlat0.xxxx * in_v.color);
          u_xlat1 = (u_xlat1 * float4(float4(_Multiplier, _Multiplier, _Multiplier, _Multiplier)));
          out_v.texcoord1 = u_xlat1;
          u_xlat0.xyz = (float3(u_xlat4, u_xlat4, u_xlat4) * in_v.normal.xyz);
          u_xlat0.xyz = (u_xlat0.xyz * in_v.color.www);
          u_xlat0.xyz = (((-u_xlat0.xyz) * float3(float3(_ContractionAmount, _ContractionAmount, _ContractionAmount))) + in_v.vertex.xyz);
          out_v.vertex = UnityObjectToClipPos(u_xlat0);
          out_v.texcoord.xy = in_v.texcoord.xy;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat16_0;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat0_d = (u_xlat16_0 * in_f.texcoord1);
          out_f.color = u_xlat0_d;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
