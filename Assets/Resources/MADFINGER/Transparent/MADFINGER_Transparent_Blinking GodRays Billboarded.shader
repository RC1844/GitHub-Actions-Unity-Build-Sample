Shader "MADFINGER/Transparent/Blinking GodRays Billboarded"
{
  Properties
  {
    _MainTex ("Base texture", 2D) = "white" {}
    _FadeOutDistNear ("Near fadeout dist", float) = 10
    _FadeOutDistFar ("Far fadeout dist", float) = 10000
    _Multiplier ("Color multiplier", float) = 1
    _Bias ("Bias", float) = 0
    _TimeOnDuration ("ON duration", float) = 0.5
    _TimeOffDuration ("OFF duration", float) = 0.5
    _BlinkingTimeOffsScale ("Blinking time offset scale (seconds)", float) = 5
    _SizeGrowStartDist ("Size grow start dist", float) = 5
    _SizeGrowEndDist ("Size grow end dist", float) = 50
    _MaxGrowSize ("Max grow size", float) = 2.5
    _NoiseAmount ("Noise amount (when zero, pulse wave is used)", Range(0, 0.5)) = 0
    _VerticalBillboarding ("Vertical billboarding amount", Range(0, 1)) = 1
    _ViewerOffset ("Viewer offset", float) = 0
    _Color ("Color", Color) = (1,1,1,1)
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
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      uniform float _FadeOutDistNear;
      uniform float _FadeOutDistFar;
      uniform float _Multiplier;
      uniform float _Bias;
      uniform float _TimeOnDuration;
      uniform float _TimeOffDuration;
      uniform float _BlinkingTimeOffsScale;
      uniform float _SizeGrowStartDist;
      uniform float _SizeGrowEndDist;
      uniform float _MaxGrowSize;
      uniform float _NoiseAmount;
      uniform float _VerticalBillboarding;
      uniform float _ViewerOffset;
      uniform float4 _Color;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
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
      float4 u_xlat2;
      float3 u_xlat3;
      float3 u_xlat4;
      float3 u_xlat5;
      float u_xlat6;
      float3 u_xlat7;
      float u_xlat13;
      int u_xlatb13;
      float u_xlat19;
      int u_xlatb19;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.xyz = mul(unity_WorldToObject, _WorldSpaceCameraPos.xyz);
          u_xlat1.z = 0;
          u_xlat2.xy = ((-in_v.color.xy) + float2(0.5, 0.5));
          u_xlat1.xy = (u_xlat2.xy * in_v.texcoord1.xy);
          u_xlat2.xyz = (u_xlat1.xyz + in_v.vertex.xyz);
          u_xlat0.xyz = (u_xlat0.xyz + (-u_xlat2.xyz));
          u_xlat0.w = (u_xlat0.y * _VerticalBillboarding);
          u_xlat6 = length(u_xlat0.xzw);
          u_xlat3.xyz = (u_xlat0.zxw / float3(u_xlat6, u_xlat6, u_xlat6));
          #ifdef UNITY_ADRENO_ES3
          u_xlatb13 = (0.999000013<abs(u_xlat3.z));
          #else
          u_xlatb13 = (0.999000013<abs(u_xlat3.z));
          #endif
          u_xlat4.xyz = float3((int(u_xlatb13))?(float3(1, 0, 0)):(float3(0, 0, 1)));
          u_xlat5.xyz = (u_xlat3.zxy * u_xlat4.xyz);
          u_xlat4.xyz = ((u_xlat4.zxy * u_xlat3.xyz) + (-u_xlat5.xyz));
          u_xlat4.xyz = normalize(u_xlat4.xyz);
          u_xlat5.xyz = (u_xlat3.xyz * u_xlat4.yzx);
          u_xlat3.xyz = ((u_xlat3.zxy * u_xlat4.zxy) + (-u_xlat5.xyz));
          u_xlat7.xyz = (u_xlat1.yyy * u_xlat3.xyz);
          u_xlat3.xyz = (u_xlat3.xyz * in_v.normal.yyy);
          u_xlat3.xyz = ((u_xlat4.xyz * in_v.normal.xxx) + u_xlat3.xyz);
          u_xlat1.xyz = ((u_xlat4.xyz * u_xlat1.xxx) + u_xlat7.xyz);
          u_xlat1.xyz = ((-u_xlat1.xyz) + u_xlat2.xyz);
          u_xlat19 = (u_xlat6 + (-_SizeGrowStartDist));
          u_xlat19 = max(u_xlat19, 0);
          u_xlat19 = (u_xlat19 / _SizeGrowEndDist);
          u_xlat19 = min(u_xlat19, 1);
          u_xlat19 = (u_xlat19 * u_xlat19);
          u_xlat19 = (u_xlat19 * _MaxGrowSize);
          u_xlat19 = (u_xlat19 * in_v.color.w);
          u_xlat1.xyz = ((u_xlat3.xyz * float3(u_xlat19, u_xlat19, u_xlat19)) + u_xlat1.xyz);
          u_xlat0.xzw = ((float3(_ViewerOffset, _ViewerOffset, _ViewerOffset) * u_xlat0.xwz) + u_xlat1.xyz);
          u_xlat1 = (u_xlat0.zzzz * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat1 = ((conv_mxt4x4_0(unity_ObjectToWorld) * u_xlat0.xxxx) + u_xlat1);
          u_xlat1 = ((conv_mxt4x4_2(unity_ObjectToWorld) * u_xlat0.wwww) + u_xlat1);
          u_xlat1 = (u_xlat1 + conv_mxt4x4_3(unity_ObjectToWorld));
          out_v.vertex = mul(unity_MatrixVP, u_xlat1);
          out_v.texcoord.xy = in_v.texcoord.xy;
          u_xlat0.x = (u_xlat6 + (-_FadeOutDistFar));
          u_xlat6 = (u_xlat6 / _FadeOutDistNear);
          #ifdef UNITY_ADRENO_ES3
          u_xlat6 = min(max(u_xlat6, 0), 1);
          #else
          u_xlat6 = clamp(u_xlat6, 0, 1);
          #endif
          u_xlat0.y = (u_xlat6 * u_xlat6);
          u_xlat0.x = max(u_xlat0.x, 0);
          u_xlat0.x = (u_xlat0.x * 0.200000003);
          u_xlat0.x = min(u_xlat0.x, 1);
          u_xlat0.x = ((-u_xlat0.x) + 1);
          u_xlat0.xy = (u_xlat0.xy * u_xlat0.xy);
          u_xlat0.x = (u_xlat0.x * u_xlat0.y);
          u_xlat0 = (u_xlat0.xxxx * _Color);
          u_xlat0 = (u_xlat0 * float4(float4(_Multiplier, _Multiplier, _Multiplier, _Multiplier)));
          u_xlat1.x = ((_BlinkingTimeOffsScale * in_v.color.z) + _Time.y);
          u_xlat7.x = (_TimeOffDuration + _TimeOnDuration);
          u_xlat13 = (u_xlat1.x / u_xlat7.x);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb19 = (u_xlat13>=(-u_xlat13));
          #else
          u_xlatb19 = (u_xlat13>=(-u_xlat13));
          #endif
          u_xlat13 = frac(abs(u_xlat13));
          u_xlat13 = (u_xlatb19)?(u_xlat13):((-u_xlat13));
          u_xlat2.xy = float2((float2(_TimeOnDuration, _TimeOnDuration) * float2(0.25, 0.75)));
          u_xlat7.z = ((u_xlat13 * u_xlat7.x) + (-u_xlat2.y));
          u_xlat7.x = (u_xlat7.x * u_xlat13);
          u_xlat13 = (float(1) / u_xlat2.x);
          u_xlat7.xz = (float2(u_xlat13, u_xlat13) * u_xlat7.xz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat7.xz = min(max(u_xlat7.xz, 0), 1);
          #else
          u_xlat7.xz = clamp(u_xlat7.xz, 0, 1);
          #endif
          u_xlat13 = ((u_xlat7.z * (-2)) + 3);
          u_xlat19 = (u_xlat7.z * u_xlat7.z);
          u_xlat13 = (((-u_xlat13) * u_xlat19) + 1);
          u_xlat19 = ((u_xlat7.x * (-2)) + 3);
          u_xlat7.x = (u_xlat7.x * u_xlat7.x);
          u_xlat7.x = (u_xlat7.x * u_xlat19);
          u_xlat7.x = (u_xlat13 * u_xlat7.x);
          u_xlat13 = (6.28318548 / _TimeOnDuration);
          u_xlat1.x = (u_xlat13 * u_xlat1.x);
          u_xlat13 = ((u_xlat1.x * 0.636600018) + 56.7271996);
          u_xlat1.x = sin(u_xlat1.x);
          u_xlat13 = cos(u_xlat13);
          u_xlat13 = ((u_xlat13 * 0.5) + 0.5);
          u_xlat1.x = (u_xlat13 * u_xlat1.x);
          u_xlat1.x = ((_NoiseAmount * u_xlat1.x) + (-_NoiseAmount));
          u_xlat1.x = (u_xlat1.x + 1);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb13 = (_NoiseAmount<0.00999999978);
          #else
          u_xlatb13 = (_NoiseAmount<0.00999999978);
          #endif
          u_xlat1.x = (u_xlatb13)?(u_xlat7.x):(u_xlat1.x);
          u_xlat1.x = (u_xlat1.x + _Bias);
          u_xlat0 = (u_xlat0 * u_xlat1.xxxx);
          out_v.texcoord1 = u_xlat0;
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
