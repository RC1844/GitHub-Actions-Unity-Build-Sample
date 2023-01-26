Shader "MADFINGER/Environment/Lightprobes with VirtualGloss Per-Vertex Additive"
{
  Properties
  {
    _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
    _SpecOffset ("Specular Offset from Camera", Vector) = (1,10,2,0)
    _SpecRange ("Specular Range", float) = 20
    _SpecColor ("Specular Color", Color) = (1,1,1,1)
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
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 unity_SHAr;
      //uniform float4 unity_SHAg;
      //uniform float4 unity_SHAb;
      //uniform float4 unity_SHBr;
      //uniform float4 unity_SHBg;
      //uniform float4 unity_SHBb;
      //uniform float4 unity_SHC;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float3 _SpecOffset;
      uniform float _SpecRange;
      uniform float3 _SpecColor;
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
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat16_1;
      float3 u_xlat2;
      float3 u_xlat3;
      float3 u_xlat16_4;
      float3 u_xlat16_5;
      float3 u_xlat6;
      float u_xlat12;
      float u_xlat18;
      float u_xlat19;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          out_v.texcoord.xy = in_v.texcoord.xy;
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
          u_xlat18 = dot((-u_xlat0.xyz), (-u_xlat0.xyz));
          u_xlat18 = rsqrt(u_xlat18);
          u_xlat2.xyz = (((-u_xlat0.xyz) * float3(u_xlat18, u_xlat18, u_xlat18)) + float3(0, 0, 1));
          u_xlat0.x = length(u_xlat0.xyz);
          u_xlat0.x = (u_xlat0.x / _SpecRange);
          #ifdef UNITY_ADRENO_ES3
          u_xlat0.x = min(max(u_xlat0.x, 0), 1);
          #else
          u_xlat0.x = clamp(u_xlat0.x, 0, 1);
          #endif
          u_xlat0.x = ((-u_xlat0.x) + 1);
          u_xlat6.xyz = (u_xlat2.xyz * float3(0.5, 0.5, 0.5));
          u_xlat19 = dot(u_xlat6.xyz, u_xlat6.xyz);
          u_xlat19 = rsqrt(u_xlat19);
          u_xlat6.xyz = (u_xlat6.xyz * float3(u_xlat19, u_xlat19, u_xlat19));
          u_xlat6.x = dot(u_xlat1.xyz, u_xlat6.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat6.x = min(max(u_xlat6.x, 0), 1);
          #else
          u_xlat6.x = clamp(u_xlat6.x, 0, 1);
          #endif
          u_xlat6.x = log2(u_xlat6.x);
          u_xlat12 = (_Shininess * 128);
          u_xlat6.x = (u_xlat6.x * u_xlat12);
          u_xlat6.x = exp2(u_xlat6.x);
          u_xlat6.xyz = (u_xlat6.xxx * _SpecColor.xyz);
          u_xlat0.xyz = (u_xlat0.xxx * u_xlat6.xyz);
          u_xlat0.xyz = (u_xlat0.xyz + u_xlat0.xyz);
          out_v.texcoord3.xyz = u_xlat0.xyz;
          u_xlat0.xyz = (in_v.normal.yyy * conv_mxt4x4_1(unity_ObjectToWorld).xyz);
          u_xlat0.xyz = ((conv_mxt4x4_0(unity_ObjectToWorld).xyz * in_v.normal.xxx) + u_xlat0.xyz);
          u_xlat0.xyz = ((conv_mxt4x4_2(unity_ObjectToWorld).xyz * in_v.normal.zzz) + u_xlat0.xyz);
          u_xlat16_4.x = (u_xlat0.y * u_xlat0.y);
          u_xlat16_4.x = ((u_xlat0.x * u_xlat0.x) + (-u_xlat16_4.x));
          u_xlat16_1 = (u_xlat0.yzzx * u_xlat0.xyzz);
          u_xlat16_5.x = dot(unity_SHBr, u_xlat16_1);
          u_xlat16_5.y = dot(unity_SHBg, u_xlat16_1);
          u_xlat16_5.z = dot(unity_SHBb, u_xlat16_1);
          u_xlat16_4.xyz = ((unity_SHC.xyz * u_xlat16_4.xxx) + u_xlat16_5.xyz);
          u_xlat0.w = 1;
          u_xlat16_5.x = dot(unity_SHAr, u_xlat0);
          u_xlat16_5.y = dot(unity_SHAg, u_xlat0);
          u_xlat16_5.z = dot(unity_SHAb, u_xlat0);
          u_xlat16_4.xyz = (u_xlat16_4.xyz + u_xlat16_5.xyz);
          u_xlat0.xyz = (u_xlat16_4.xyz * float3(_SHLightingScale, _SHLightingScale, _SHLightingScale));
          out_v.texcoord4.xyz = u_xlat0.xyz;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      float3 u_xlat16_1_d;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_1_d.xyz = (u_xlat16_0.www * in_f.texcoord3.xyz);
          out_f.color.xyz = ((u_xlat16_0.xyz * in_f.texcoord4.xyz) + u_xlat16_1_d.xyz);
          out_f.color.w = u_xlat16_0.w;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
