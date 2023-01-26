Shader "S_Project/Toon"
{
  Properties
  {
    _Color ("Main Color", Color) = (1,1,1,1)
    _LightProbeValue ("LightProbeValue", float) = 1
    _RimPower ("Rim Power", float) = 3
    _RimScale ("Rim Scale", float) = 1.5
    _MainTex ("Diffuse", 2D) = "white" {}
    _RimLightSampler ("RimLight Control", 2D) = "white" {}
    _FallOffValue ("Falloff value", Range(0, 1)) = 0.5
    _ShadowSubValue ("ShadowSub value", float) = 1
    _Flash ("Flash Program Use", float) = 1
  }
  SubShader
  {
    Tags
    { 
      "LIGHTMODE" = "FORWARDBASE"
      "QUEUE" = "Geometry"
      "RenderType" = "Opaque"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "QUEUE" = "Geometry"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile DIRECTIONAL
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      //uniform float4 unity_SHAr;
      //uniform float4 unity_SHAg;
      //uniform float4 unity_SHAb;
      //uniform float4 unity_SHBr;
      //uniform float4 unity_SHBg;
      //uniform float4 unity_SHBb;
      //uniform float4 unity_SHC;
      uniform float4 _Color;
      uniform float _RimPower;
      uniform float _RimScale;
      uniform float _LightProbeValue;
      uniform float _Flash;
      uniform float _FallOffValue;
      uniform sampler2D _MainTex;
      uniform sampler2D _RimLightSampler;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
          float3 texcoord5 :TEXCOORD5;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
          float3 texcoord5 :TEXCOORD5;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float u_xlat9;
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
          out_v.texcoord2.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.texcoord3.xyz = normalize(u_xlat0.xyz);
          out_v.texcoord4.xyz = _WorldSpaceLightPos0.xyz;
          u_xlat0.xyz = (in_v.normal.yyy * conv_mxt4x4_1(unity_ObjectToWorld).xyz);
          u_xlat0.xyz = ((conv_mxt4x4_0(unity_ObjectToWorld).xyz * in_v.normal.xxx) + u_xlat0.xyz);
          u_xlat0.xyz = ((conv_mxt4x4_2(unity_ObjectToWorld).xyz * in_v.normal.zzz) + u_xlat0.xyz);
          out_v.texcoord5.xyz = normalize(u_xlat0.xyz);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      float4 u_xlat1_d;
      float4 u_xlat16_1;
      float3 u_xlat16_2;
      float3 u_xlat3;
      float3 u_xlat4;
      float3 u_xlat16_4;
      float u_xlat16_17;
      float u_xlat18;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0.x = (in_f.texcoord5.y * in_f.texcoord5.y);
          u_xlat16_0.x = ((in_f.texcoord5.x * in_f.texcoord5.x) + (-u_xlat16_0.x));
          u_xlat16_1 = (in_f.texcoord5.yzzx * in_f.texcoord5.xyzz);
          u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
          u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
          u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
          u_xlat16_0.xyz = ((unity_SHC.xyz * u_xlat16_0.xxx) + u_xlat16_2.xyz);
          u_xlat1_d.xyz = in_f.texcoord5.xyz;
          u_xlat1_d.w = 1;
          u_xlat16_2.x = dot(unity_SHAr, u_xlat1_d);
          u_xlat16_2.y = dot(unity_SHAg, u_xlat1_d);
          u_xlat16_2.z = dot(unity_SHAb, u_xlat1_d);
          u_xlat16_0.xyz = (u_xlat16_0.xyz + u_xlat16_2.xyz);
          u_xlat3.x = ((-_LightProbeValue) + 1);
          u_xlat3.xyz = ((u_xlat16_0.xyz * float3(float3(_LightProbeValue, _LightProbeValue, _LightProbeValue))) + u_xlat3.xxx);
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord2.xy);
          u_xlat16_2.xyz = (u_xlat3.xyz * u_xlat16_0.xyz);
          out_f.color.w = (u_xlat16_0.w * _Color.w);
          u_xlat3.xyz = (u_xlat16_2.xyz * float3(float3(_RimScale, _RimScale, _RimScale)));
          u_xlat16_17 = dot(in_f.texcoord5.xyz, in_f.texcoord3.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_17 = min(max(u_xlat16_17, 0), 1);
          #else
          u_xlat16_17 = clamp(u_xlat16_17, 0, 1);
          #endif
          u_xlat16_17 = ((-u_xlat16_17) + 1);
          u_xlat18 = log2(u_xlat16_17);
          u_xlat18 = (u_xlat18 * _RimPower);
          u_xlat18 = exp2(u_xlat18);
          u_xlat3.xyz = (float3(u_xlat18, u_xlat18, u_xlat18) * u_xlat3.xyz);
          u_xlat18 = dot(in_f.texcoord5.xyz, (-in_f.texcoord4.xyz));
          u_xlat18 = ((-u_xlat18) + 1);
          u_xlat4.x = max(u_xlat18, 0);
          u_xlat4.y = 0.25;
          u_xlat16_4.xyz = tex2D(_RimLightSampler, u_xlat4.xy).xyz;
          u_xlat4.xyz = ((u_xlat16_4.xyz * float3(_FallOffValue, _FallOffValue, _FallOffValue)) + float3(1, 1, 1));
          u_xlat4.xyz = (u_xlat4.xyz + (-float3(_FallOffValue, _FallOffValue, _FallOffValue)));
          u_xlat16_2.xyz = ((u_xlat16_2.xyz * u_xlat4.xyz) + u_xlat3.xyz);
          u_xlat3.x = (_Flash + (-1));
          out_f.color.xyz = ((_Color.xyz * u_xlat3.xxx) + u_xlat16_2.xyz);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Transparent/Cutout/Diffuse"
}
