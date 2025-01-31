Shader "Toon/Basic/TwoSteps"
{
  Properties
  {
    _Color ("Color", Color) = (1,1,1,1)
    _HColor ("Highlight Color", Color) = (0.8,0.8,0.8,1)
    _SColor ("Shadow Color", Color) = (0.2,0.2,0.2,1)
    _MainTex ("Main Texture", 2D) = "white" {}
    _RampThreshold ("Ramp Threshold", Range(0.1, 1)) = 0.5
    _RampSmooth ("Ramp Smooth", Range(0, 1)) = 0.1
    _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
    _SpecSmooth ("Specular Smooth", Range(0, 1)) = 0.1
    _Shininess ("Shininess", Range(0.001, 10)) = 0.2
    _RimColor ("Rim Color", Color) = (0.8,0.8,0.8,0.6)
    _RimThreshold ("Rim Threshold", Range(0, 1)) = 0.5
    _RimSmooth ("Rim Smooth", Range(0, 1)) = 0.1
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    Pass // ind: 1, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _WorldSpaceLightPos0;
      uniform float4 _LightColor0;
      uniform float4 _SpecColor;
      uniform float4 _Color;
      uniform float4 _HColor;
      uniform float4 _SColor;
      uniform float _RampThreshold;
      uniform float _RampSmooth;
      uniform float _SpecSmooth;
      uniform float _Shininess;
      uniform float4 _RimColor;
      uniform float _RimThreshold;
      uniform float _RimSmooth;
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
          float3 texcoord3 :TEXCOORD3;
          float4 texcoord5 :TEXCOORD5;
          float4 texcoord6 :TEXCOORD6;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float u_xlat6;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          out_v.texcoord2.xyz = ((conv_mxt4x4_3(unity_ObjectToWorld).xyz * in_v.vertex.www) + u_xlat0.xyz);
          out_v.vertex = mul(unity_MatrixVP, u_xlat1);
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          u_xlat0.x = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat0.y = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat0.z = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          out_v.texcoord1.xyz = normalize(u_xlat0.xyz);
          out_v.texcoord3.xyz = float3(0, 0, 0);
          out_v.texcoord5 = float4(0, 0, 0, 0);
          out_v.texcoord6 = float4(0, 0, 0, 0);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float4 u_xlat16_1;
      float3 u_xlat16_2;
      float3 u_xlat3;
      float3 u_xlat16_4;
      float3 u_xlat16_5;
      float u_xlat6_d;
      float3 u_xlat16_8;
      float u_xlat9;
      float u_xlat12;
      float u_xlat18;
      float u_xlat16_19;
      float u_xlat16_20;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xyz = ((-in_f.texcoord2.xyz) + _WorldSpaceCameraPos.xyz);
          u_xlat18 = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          u_xlat18 = rsqrt(u_xlat18);
          u_xlat16_1.xyz = ((u_xlat0_d.xyz * float3(u_xlat18, u_xlat18, u_xlat18)) + _WorldSpaceLightPos0.xyz);
          u_xlat0_d.xyz = (float3(u_xlat18, u_xlat18, u_xlat18) * u_xlat0_d.xyz);
          u_xlat16_1.xyz = normalize(u_xlat16_1.xyz);
          u_xlat16_2.xyz = normalize(in_f.texcoord1.xyz);
          u_xlat16_1.x = dot(u_xlat16_2.xyz, u_xlat16_1.xyz);
          u_xlat16_1.x = max(u_xlat16_1.x, 0);
          u_xlat18 = log2(u_xlat16_1.x);
          u_xlat16_1.x = (_Shininess * 128);
          u_xlat18 = (u_xlat18 * u_xlat16_1.x);
          u_xlat18 = exp2(u_xlat18);
          u_xlat16_1 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat3.x = (((-_SpecSmooth) * 0.5) + 0.5);
          u_xlat18 = ((u_xlat18 * u_xlat16_1.w) + (-u_xlat3.x));
          u_xlat16_4.xyz = (u_xlat16_1.xyz * _Color.xyz);
          u_xlat9 = ((_SpecSmooth * 0.5) + 0.5);
          u_xlat3.x = ((-u_xlat3.x) + u_xlat9);
          u_xlat3.x = (float(1) / u_xlat3.x);
          u_xlat18 = (u_xlat18 * u_xlat3.x);
          #ifdef UNITY_ADRENO_ES3
          u_xlat18 = min(max(u_xlat18, 0), 1);
          #else
          u_xlat18 = clamp(u_xlat18, 0, 1);
          #endif
          u_xlat3.x = ((u_xlat18 * (-2)) + 3);
          u_xlat18 = (u_xlat18 * u_xlat18);
          u_xlat18 = (u_xlat18 * u_xlat3.x);
          u_xlat16_5.xyz = (_LightColor0.xyz * _SpecColor.xyz);
          u_xlat3.xyz = (float3(u_xlat18, u_xlat18, u_xlat18) * u_xlat16_5.xyz);
          u_xlat16_20 = dot(u_xlat16_2.xyz, _WorldSpaceLightPos0.xyz);
          u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat0_d.xyz);
          u_xlat16_2.x = max(u_xlat16_2.x, 0);
          u_xlat0_d.x = ((-u_xlat16_2.x) + 1);
          u_xlat16_2.x = max(u_xlat16_20, 0);
          u_xlat6_d = (((-_RampSmooth) * 0.5) + _RampThreshold);
          u_xlat12 = ((-u_xlat6_d) + u_xlat16_2.x);
          u_xlat18 = ((_RampSmooth * 0.5) + _RampThreshold);
          u_xlat6_d = ((-u_xlat6_d) + u_xlat18);
          u_xlat6_d = (float(1) / u_xlat6_d);
          u_xlat6_d = (u_xlat6_d * u_xlat12);
          #ifdef UNITY_ADRENO_ES3
          u_xlat6_d = min(max(u_xlat6_d, 0), 1);
          #else
          u_xlat6_d = clamp(u_xlat6_d, 0, 1);
          #endif
          u_xlat12 = ((u_xlat6_d * (-2)) + 3);
          u_xlat6_d = (u_xlat6_d * u_xlat6_d);
          u_xlat6_d = (u_xlat6_d * u_xlat12);
          u_xlat16_8.xyz = ((-_HColor.xyz) + _SColor.xyz);
          u_xlat16_8.xyz = ((_SColor.www * u_xlat16_8.xyz) + _HColor.xyz);
          u_xlat16_5.xyz = ((-u_xlat16_8.xyz) + _HColor.xyz);
          u_xlat16_8.xyz = ((float3(u_xlat6_d, u_xlat6_d, u_xlat6_d) * u_xlat16_5.xyz) + u_xlat16_8.xyz);
          u_xlat16_5.xyz = (u_xlat16_4.xyz * _LightColor0.xyz);
          u_xlat16_8.xyz = ((u_xlat16_5.xyz * u_xlat16_8.xyz) + u_xlat3.xyz);
          u_xlat6_d = (((-_RimSmooth) * 0.5) + _RimThreshold);
          u_xlat0_d.x = ((u_xlat0_d.x * u_xlat16_2.x) + (-u_xlat6_d));
          u_xlat12 = ((_RimSmooth * 0.5) + _RimThreshold);
          u_xlat6_d = ((-u_xlat6_d) + u_xlat12);
          u_xlat6_d = (float(1) / u_xlat6_d);
          u_xlat0_d.x = (u_xlat6_d * u_xlat0_d.x);
          #ifdef UNITY_ADRENO_ES3
          u_xlat0_d.x = min(max(u_xlat0_d.x, 0), 1);
          #else
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0, 1);
          #endif
          u_xlat6_d = ((u_xlat0_d.x * (-2)) + 3);
          u_xlat0_d.x = (u_xlat0_d.x * u_xlat0_d.x);
          u_xlat0_d.x = (u_xlat0_d.x * u_xlat6_d);
          u_xlat16_5.xyz = (_LightColor0.xyz * _RimColor.xyz);
          u_xlat16_5.xyz = (u_xlat16_5.xyz * _RimColor.www);
          u_xlat16_2.xyz = ((u_xlat16_5.xyz * u_xlat0_d.xxx) + u_xlat16_8.xyz);
          out_f.color.xyz = ((u_xlat16_4.xyz * in_f.texcoord3.xyz) + u_xlat16_2.xyz);
          out_f.color.w = 1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "LIGHTMODE" = "FORWARDADD"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      ZWrite Off
      Blend One One
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile POINT
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      uniform float4x4 unity_WorldToLight;
      uniform float4 _MainTex_ST;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _WorldSpaceLightPos0;
      uniform float4 _LightColor0;
      uniform float4 _SpecColor;
      uniform float4 _Color;
      uniform float4 _HColor;
      uniform float4 _SColor;
      uniform float _RampThreshold;
      uniform float _RampSmooth;
      uniform float _SpecSmooth;
      uniform float _Shininess;
      uniform float4 _RimColor;
      uniform float _RimThreshold;
      uniform float _RimSmooth;
      uniform sampler2D _MainTex;
      uniform sampler2D _LightTexture0;
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
          float3 texcoord3 :TEXCOORD3;
          float4 texcoord4 :TEXCOORD4;
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
      float u_xlat10;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat1 = mul(unity_ObjectToWorld, float4(in_v.vertex.xyz,1.0));
          out_v.vertex = mul(unity_MatrixVP, u_xlat1);
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          u_xlat1.x = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat1.y = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat1.z = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          out_v.texcoord1.xyz = normalize(u_xlat1.xyz);
          out_v.texcoord2.xyz = ((conv_mxt4x4_3(unity_ObjectToWorld).xyz * in_v.vertex.www) + u_xlat0.xyz);
          u_xlat0 = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat0);
          u_xlat1.xyz = (u_xlat0.yyy * conv_mxt4x4_1(unity_WorldToLight).xyz);
          u_xlat1.xyz = ((conv_mxt4x4_0(unity_WorldToLight).xyz * u_xlat0.xxx) + u_xlat1.xyz);
          u_xlat0.xyz = ((conv_mxt4x4_2(unity_WorldToLight).xyz * u_xlat0.zzz) + u_xlat1.xyz);
          out_v.texcoord3.xyz = ((conv_mxt4x4_3(unity_WorldToLight).xyz * u_xlat0.www) + u_xlat0.xyz);
          out_v.texcoord4 = float4(0, 0, 0, 0);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float3 u_xlat1_d;
      float4 u_xlat16_2;
      float3 u_xlat16_3;
      float3 u_xlat16_4;
      float3 u_xlat5;
      float3 u_xlat16_6;
      float u_xlat7;
      float3 u_xlat16_10;
      float u_xlat12;
      float u_xlat14;
      float u_xlat21;
      float u_xlat22;
      float u_xlat16_23;
      float u_xlat16_24;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xyz = ((-in_f.texcoord2.xyz) + _WorldSpaceCameraPos.xyz);
          u_xlat0_d.xyz = normalize(u_xlat0_d.xyz);
          u_xlat1_d.xyz = ((-in_f.texcoord2.xyz) + _WorldSpaceLightPos0.xyz);
          u_xlat21 = dot(u_xlat1_d.xyz, u_xlat1_d.xyz);
          u_xlat21 = rsqrt(u_xlat21);
          u_xlat16_2.xyz = ((u_xlat1_d.xyz * float3(u_xlat21, u_xlat21, u_xlat21)) + u_xlat0_d.xyz);
          u_xlat1_d.xyz = (float3(u_xlat21, u_xlat21, u_xlat21) * u_xlat1_d.xyz);
          u_xlat16_2.xyz = normalize(u_xlat16_2.xyz);
          u_xlat16_3.xyz = normalize(in_f.texcoord1.xyz);
          u_xlat16_2.x = dot(u_xlat16_3.xyz, u_xlat16_2.xyz);
          u_xlat16_2.x = max(u_xlat16_2.x, 0);
          u_xlat21 = log2(u_xlat16_2.x);
          u_xlat16_2.x = (_Shininess * 128);
          u_xlat21 = (u_xlat21 * u_xlat16_2.x);
          u_xlat21 = exp2(u_xlat21);
          u_xlat16_2 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat21 = (u_xlat21 * u_xlat16_2.w);
          u_xlat16_4.xyz = (u_xlat16_2.xyz * _Color.xyz);
          u_xlat16_4.xyz = (u_xlat16_4.xyz * _LightColor0.xyz);
          u_xlat5.xyz = (in_f.texcoord2.yyy * conv_mxt4x4_1(unity_WorldToLight).xyz);
          u_xlat5.xyz = ((conv_mxt4x4_0(unity_WorldToLight).xyz * in_f.texcoord2.xxx) + u_xlat5.xyz);
          u_xlat5.xyz = ((conv_mxt4x4_2(unity_WorldToLight).xyz * in_f.texcoord2.zzz) + u_xlat5.xyz);
          u_xlat5.xyz = (u_xlat5.xyz + conv_mxt4x4_3(unity_WorldToLight).xyz);
          u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
          u_xlat22 = tex2D(_LightTexture0, float2(u_xlat22, u_xlat22)).x;
          u_xlat5.x = (((-_SpecSmooth) * 0.5) + 0.5);
          u_xlat21 = ((u_xlat21 * u_xlat22) + (-u_xlat5.x));
          u_xlat12 = ((_SpecSmooth * 0.5) + 0.5);
          u_xlat5.x = ((-u_xlat5.x) + u_xlat12);
          u_xlat5.x = (float(1) / u_xlat5.x);
          u_xlat21 = (u_xlat21 * u_xlat5.x);
          #ifdef UNITY_ADRENO_ES3
          u_xlat21 = min(max(u_xlat21, 0), 1);
          #else
          u_xlat21 = clamp(u_xlat21, 0, 1);
          #endif
          u_xlat5.x = ((u_xlat21 * (-2)) + 3);
          u_xlat21 = (u_xlat21 * u_xlat21);
          u_xlat21 = (u_xlat21 * u_xlat5.x);
          u_xlat16_6.xyz = (_LightColor0.xyz * _SpecColor.xyz);
          u_xlat5.xyz = (float3(u_xlat21, u_xlat21, u_xlat21) * u_xlat16_6.xyz);
          u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat1_d.xyz);
          u_xlat16_3.x = dot(u_xlat16_3.xyz, u_xlat0_d.xyz);
          u_xlat16_3.x = max(u_xlat16_3.x, 0);
          u_xlat0_d.x = ((-u_xlat16_3.x) + 1);
          u_xlat16_3.x = max(u_xlat16_24, 0);
          u_xlat7 = (((-_RampSmooth) * 0.5) + _RampThreshold);
          u_xlat14 = ((-u_xlat7) + u_xlat16_3.x);
          u_xlat0_d.x = (u_xlat0_d.x * u_xlat16_3.x);
          u_xlat21 = ((_RampSmooth * 0.5) + _RampThreshold);
          u_xlat7 = ((-u_xlat7) + u_xlat21);
          u_xlat7 = (float(1) / u_xlat7);
          u_xlat7 = (u_xlat7 * u_xlat14);
          #ifdef UNITY_ADRENO_ES3
          u_xlat7 = min(max(u_xlat7, 0), 1);
          #else
          u_xlat7 = clamp(u_xlat7, 0, 1);
          #endif
          u_xlat14 = ((u_xlat7 * (-2)) + 3);
          u_xlat7 = (u_xlat7 * u_xlat7);
          u_xlat7 = (u_xlat7 * u_xlat14);
          u_xlat16_3.x = (u_xlat22 * u_xlat7);
          u_xlat16_10.xyz = ((-_HColor.xyz) + _SColor.xyz);
          u_xlat16_10.xyz = ((_SColor.www * u_xlat16_10.xyz) + _HColor.xyz);
          u_xlat16_6.xyz = ((-u_xlat16_10.xyz) + _HColor.xyz);
          u_xlat16_3.xyz = ((u_xlat16_3.xxx * u_xlat16_6.xyz) + u_xlat16_10.xyz);
          u_xlat16_3.xyz = ((u_xlat16_4.xyz * u_xlat16_3.xyz) + u_xlat5.xyz);
          u_xlat7 = (((-_RimSmooth) * 0.5) + _RimThreshold);
          u_xlat0_d.x = ((u_xlat0_d.x * u_xlat22) + (-u_xlat7));
          u_xlat14 = ((_RimSmooth * 0.5) + _RimThreshold);
          u_xlat7 = ((-u_xlat7) + u_xlat14);
          u_xlat7 = (float(1) / u_xlat7);
          u_xlat0_d.x = (u_xlat7 * u_xlat0_d.x);
          #ifdef UNITY_ADRENO_ES3
          u_xlat0_d.x = min(max(u_xlat0_d.x, 0), 1);
          #else
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0, 1);
          #endif
          u_xlat7 = ((u_xlat0_d.x * (-2)) + 3);
          u_xlat0_d.x = (u_xlat0_d.x * u_xlat0_d.x);
          u_xlat0_d.x = (u_xlat0_d.x * u_xlat7);
          u_xlat16_4.xyz = (_LightColor0.xyz * _RimColor.xyz);
          u_xlat16_4.xyz = (u_xlat16_4.xyz * _RimColor.www);
          out_f.color.xyz = ((u_xlat16_4.xyz * u_xlat0_d.xxx) + u_xlat16_3.xyz);
          out_f.color.w = 1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: ShadowCaster
    {
      Name "ShadowCaster"
      Tags
      { 
        "LIGHTMODE" = "SHADOWCASTER"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile SHADOWS_DEPTH
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _WorldSpaceLightPos0;
      //uniform float4 unity_LightShadowBias;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
      };
      
      struct OUT_Data_Vert
      {
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 vertex :Position;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float u_xlat6;
      float u_xlat9;
      int u_xlatb9;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.x = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat0.y = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat0.z = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat0.xyz = normalize(u_xlat0.xyz);
          u_xlat1 = mul(unity_ObjectToWorld, in_v.vertex);
          u_xlat2.xyz = (((-u_xlat1.xyz) * _WorldSpaceLightPos0.www) + _WorldSpaceLightPos0.xyz);
          u_xlat2.xyz = normalize(u_xlat2.xyz);
          u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
          u_xlat9 = (((-u_xlat9) * u_xlat9) + 1);
          u_xlat9 = sqrt(u_xlat9);
          u_xlat9 = (u_xlat9 * unity_LightShadowBias.z);
          u_xlat0.xyz = (((-u_xlat0.xyz) * float3(u_xlat9, u_xlat9, u_xlat9)) + u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb9 = (unity_LightShadowBias.z!=0);
          #else
          u_xlatb9 = (unity_LightShadowBias.z!=0);
          #endif
          u_xlat0.xyz = (int(u_xlatb9))?(u_xlat0.xyz):(u_xlat1.xyz);
          u_xlat0 = mul(unity_MatrixVP, u_xlat0);
          u_xlat1.x = (unity_LightShadowBias.x / u_xlat0.w);
          #ifdef UNITY_ADRENO_ES3
          u_xlat1.x = min(max(u_xlat1.x, 0), 1);
          #else
          u_xlat1.x = clamp(u_xlat1.x, 0, 1);
          #endif
          u_xlat6 = (u_xlat0.z + u_xlat1.x);
          u_xlat1.x = max((-u_xlat0.w), u_xlat6);
          out_v.vertex.xyw = u_xlat0.xyw;
          u_xlat0.x = ((-u_xlat6) + u_xlat1.x);
          out_v.vertex.z = ((unity_LightShadowBias.y * u_xlat0.x) + u_xlat6);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          out_f.color = float4(0, 0, 0, 0);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Diffuse"
}
