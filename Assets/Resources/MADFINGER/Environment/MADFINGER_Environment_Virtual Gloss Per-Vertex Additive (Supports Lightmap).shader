Shader "MADFINGER/Environment/Virtual Gloss Per-Vertex Additive (Supports Lightmap)"
{
  Properties
  {
    _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
    _SpecOffset ("Specular Offset from Camera", Vector) = (1,10,2,0)
    _SpecRange ("Specular Range", float) = 20
    _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
    _Shininess ("Shininess", Range(0.01, 1)) = 0.078125
    _ScrollingSpeed ("Scrolling speed", Vector) = (0,0,0,0)
  }
  SubShader
  {
    Tags
    { 
      "LIGHTMODE" = "FORWARDBASE"
      "RenderType" = "Opaque"
    }
    LOD 100
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "RenderType" = "Opaque"
      }
      LOD 100
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float3 _SpecOffset;
      uniform float _SpecRange;
      uniform float3 _SpecColor;
      uniform float _Shininess;
      uniform float4 _ScrollingSpeed;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord2 :TEXCOORD2;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float3 u_xlat2;
      float3 u_xlat3;
      float3 u_xlat4;
      float u_xlat8;
      float u_xlat12;
      float u_xlat13;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0.xy = (_Time.yy * _ScrollingSpeed.xy);
          u_xlat0.xy = frac(u_xlat0.xy);
          out_v.texcoord.xy = (u_xlat0.xy + in_v.texcoord.xy);
          u_xlat0.xyz = mul(unity_MatrixV, unity_ObjectToWorld[0]);
          u_xlat1.xyz = mul(unity_MatrixV, unity_ObjectToWorld[0]);
          u_xlat2.xyz = (u_xlat1.xyz * in_v.vertex.yyy);
          u_xlat1.xyz = (u_xlat1.xyz * in_v.normal.yyy);
          u_xlat3.xyz = mul(unity_MatrixV, unity_ObjectToWorld[0]);
          u_xlat2.xyz = ((u_xlat3.xyz * in_v.vertex.xxx) + u_xlat2.xyz);
          u_xlat1.xyz = ((u_xlat3.xyz * in_v.normal.xxx) + u_xlat1.xyz);
          u_xlat3.xyz = mul(unity_MatrixV, unity_ObjectToWorld[0]);
          u_xlat2.xyz = ((u_xlat3.xyz * in_v.vertex.zzz) + u_xlat2.xyz);
          u_xlat1.xyz = ((u_xlat3.xyz * in_v.normal.zzz) + u_xlat1.xyz);
          u_xlat0.xyz = ((u_xlat0.xyz * in_v.vertex.www) + u_xlat2.xyz);
          u_xlat0.xyz = (((-_SpecOffset.xyz) * float3(1, 1, (-1))) + u_xlat0.xyz);
          u_xlat12 = dot((-u_xlat0.xyz), (-u_xlat0.xyz));
          u_xlat12 = rsqrt(u_xlat12);
          u_xlat2.xyz = (((-u_xlat0.xyz) * float3(u_xlat12, u_xlat12, u_xlat12)) + float3(0, 0, 1));
          u_xlat0.x = length(u_xlat0.xyz);
          u_xlat0.x = (u_xlat0.x / _SpecRange);
          #ifdef UNITY_ADRENO_ES3
          u_xlat0.x = min(max(u_xlat0.x, 0), 1);
          #else
          u_xlat0.x = clamp(u_xlat0.x, 0, 1);
          #endif
          u_xlat0.x = ((-u_xlat0.x) + 1);
          u_xlat4.xyz = (u_xlat2.xyz * float3(0.5, 0.5, 0.5));
          u_xlat13 = dot(u_xlat4.xyz, u_xlat4.xyz);
          u_xlat13 = rsqrt(u_xlat13);
          u_xlat4.xyz = (u_xlat4.xyz * float3(u_xlat13, u_xlat13, u_xlat13));
          u_xlat4.x = dot(u_xlat1.xyz, u_xlat4.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat4.x = min(max(u_xlat4.x, 0), 1);
          #else
          u_xlat4.x = clamp(u_xlat4.x, 0, 1);
          #endif
          u_xlat4.x = log2(u_xlat4.x);
          u_xlat8 = (_Shininess * 128);
          u_xlat4.x = (u_xlat4.x * u_xlat8);
          u_xlat4.x = exp2(u_xlat4.x);
          u_xlat4.xyz = (u_xlat4.xxx * _SpecColor.xyz);
          u_xlat0.xyz = (u_xlat0.xxx * u_xlat4.xyz);
          u_xlat0.xyz = (u_xlat0.xyz + u_xlat0.xyz);
          out_v.texcoord2.xyz = u_xlat0.xyz;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy);
          out_f.color.xyz = ((in_f.texcoord2.xyz * u_xlat16_0.www) + u_xlat16_0.xyz);
          out_f.color.w = u_xlat16_0.w;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
