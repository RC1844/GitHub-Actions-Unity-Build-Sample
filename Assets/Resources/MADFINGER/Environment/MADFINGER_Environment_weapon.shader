Shader "MADFINGER/Environment/weapon"
{
  Properties
  {
    _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
    _Shininess ("Shininess", Range(0.01, 1)) = 0.078125
    _SHLightingScale ("LightProbe influence scale", float) = 1
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
      #pragma multi_compile LIGHTMAP_OFF
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _WorldSpaceLightPos0;
      //uniform float4 unity_SHAr;
      //uniform float4 unity_SHAg;
      //uniform float4 unity_SHAb;
      //uniform float4 unity_SHBr;
      //uniform float4 unity_SHBg;
      //uniform float4 unity_SHBb;
      //uniform float4 unity_SHC;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float _Shininess;
      uniform float _SHLightingScale;
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
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float4 u_xlat16_2;
      float3 u_xlat16_3;
      float3 u_xlat16_4;
      float3 u_xlat5;
      float3 u_xlat6;
      float u_xlat7;
      float u_xlat21;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          u_xlat0.xyz = ((conv_mxt4x4_3(unity_ObjectToWorld).xyz * in_v.vertex.www) + u_xlat0.xyz);
          u_xlat0.xyz = ((-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz);
          out_v.vertex = mul(unity_MatrixVP, u_xlat1);
          out_v.texcoord.xy = in_v.texcoord.xy;
          u_xlat1.xyz = (in_v.normal.yyy * conv_mxt4x4_1(unity_ObjectToWorld).xyz);
          u_xlat1.xyz = ((conv_mxt4x4_0(unity_ObjectToWorld).xyz * in_v.normal.xxx) + u_xlat1.xyz);
          u_xlat1.xyz = ((conv_mxt4x4_2(unity_ObjectToWorld).xyz * in_v.normal.zzz) + u_xlat1.xyz);
          u_xlat16_3.x = (u_xlat1.y * u_xlat1.y);
          u_xlat16_3.x = ((u_xlat1.x * u_xlat1.x) + (-u_xlat16_3.x));
          u_xlat16_2 = (u_xlat1.yzzx * u_xlat1.xyzz);
          u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
          u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
          u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
          u_xlat16_3.xyz = ((unity_SHC.xyz * u_xlat16_3.xxx) + u_xlat16_4.xyz);
          u_xlat1.w = 1;
          u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
          u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
          u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
          u_xlat16_3.xyz = (u_xlat16_3.xyz + u_xlat16_4.xyz);
          u_xlat5.xyz = normalize(u_xlat16_3.xyz);
          u_xlat6.xyz = (u_xlat16_3.xyz * float3(_SHLightingScale, _SHLightingScale, _SHLightingScale));
          out_v.texcoord2.xyz = u_xlat6.xyz;
          u_xlat21 = dot((-u_xlat0.xyz), (-u_xlat0.xyz));
          u_xlat21 = rsqrt(u_xlat21);
          u_xlat0.xyz = (float3(u_xlat21, u_xlat21, u_xlat21) * (-u_xlat0.xyz));
          u_xlat21 = dot(u_xlat0.xyz, u_xlat1.xyz);
          u_xlat21 = (u_xlat21 + u_xlat21);
          u_xlat0.xyz = ((u_xlat1.xyz * (-float3(u_xlat21, u_xlat21, u_xlat21))) + u_xlat0.xyz);
          u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat0.x = min(max(u_xlat0.x, 0), 1);
          #else
          u_xlat0.x = clamp(u_xlat0.x, 0, 1);
          #endif
          u_xlat0.x = log2(u_xlat0.x);
          u_xlat7 = (_Shininess * 128);
          u_xlat0.x = (u_xlat0.x * u_xlat7);
          u_xlat0.x = exp2(u_xlat0.x);
          u_xlat0.xyz = (u_xlat0.xxx * u_xlat5.xyz);
          u_xlat0.xyz = (u_xlat0.xyz + u_xlat0.xyz);
          out_v.texcoord1.xyz = u_xlat0.xyz;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      float3 u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_1.xyz = (u_xlat16_0.www * in_f.texcoord1.xyz);
          out_f.color.xyz = ((u_xlat16_0.xyz * in_f.texcoord2.xyz) + u_xlat16_1.xyz);
          out_f.color.w = u_xlat16_0.w;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
