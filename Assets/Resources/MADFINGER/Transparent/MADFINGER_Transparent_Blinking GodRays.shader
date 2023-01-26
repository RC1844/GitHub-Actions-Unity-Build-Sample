Shader "MADFINGER/Transparent/Blinking GodRays"
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
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
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
      uniform float4 _Color;
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
      float4 u_xlat2;
      float3 u_xlat3;
      float3 u_xlat4;
      float u_xlat7;
      int u_xlatb7;
      float u_xlat10;
      int u_xlatb10;
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
          u_xlat3.x = (u_xlat0.x + (-_SizeGrowStartDist));
          u_xlat3.x = max(u_xlat3.x, 0);
          u_xlat3.x = (u_xlat3.x / _SizeGrowEndDist);
          u_xlat3.x = min(u_xlat3.x, 1);
          u_xlat3.x = (u_xlat3.x * u_xlat3.x);
          u_xlat3.x = (u_xlat3.x * _MaxGrowSize);
          u_xlat3.x = (u_xlat3.x * in_v.color.w);
          u_xlat3.xyz = ((u_xlat3.xxx * in_v.normal.xyz) + in_v.vertex.xyz);
          out_v.vertex = UnityObjectToClipPos(float4(u_xlat3, 0));
          out_v.texcoord.xy = in_v.texcoord.xy;
          u_xlat3.x = (u_xlat0.x + (-_FadeOutDistFar));
          u_xlat0.x = (u_xlat0.x / _FadeOutDistNear);
          #ifdef UNITY_ADRENO_ES3
          u_xlat0.x = min(max(u_xlat0.x, 0), 1);
          #else
          u_xlat0.x = clamp(u_xlat0.x, 0, 1);
          #endif
          u_xlat0.x = (u_xlat0.x * u_xlat0.x);
          u_xlat3.x = max(u_xlat3.x, 0);
          u_xlat3.x = (u_xlat3.x * 0.200000003);
          u_xlat3.x = min(u_xlat3.x, 1);
          u_xlat0.y = ((-u_xlat3.x) + 1);
          u_xlat0.xy = (u_xlat0.xy * u_xlat0.xy);
          u_xlat0.x = (u_xlat0.y * u_xlat0.x);
          u_xlat0 = (u_xlat0.xxxx * _Color);
          u_xlat0 = (u_xlat0 * float4(float4(_Multiplier, _Multiplier, _Multiplier, _Multiplier)));
          u_xlat1.x = ((_BlinkingTimeOffsScale * in_v.color.z) + _Time.y);
          u_xlat4.x = (_TimeOffDuration + _TimeOnDuration);
          u_xlat7 = (u_xlat1.x / u_xlat4.x);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb10 = (u_xlat7>=(-u_xlat7));
          #else
          u_xlatb10 = (u_xlat7>=(-u_xlat7));
          #endif
          u_xlat7 = frac(abs(u_xlat7));
          u_xlat7 = (u_xlatb10)?(u_xlat7):((-u_xlat7));
          u_xlat2.xy = float2((float2(_TimeOnDuration, _TimeOnDuration) * float2(0.25, 0.75)));
          u_xlat4.z = ((u_xlat7 * u_xlat4.x) + (-u_xlat2.y));
          u_xlat4.x = (u_xlat4.x * u_xlat7);
          u_xlat7 = (float(1) / u_xlat2.x);
          u_xlat4.xz = (float2(u_xlat7, u_xlat7) * u_xlat4.xz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat4.xz = min(max(u_xlat4.xz, 0), 1);
          #else
          u_xlat4.xz = clamp(u_xlat4.xz, 0, 1);
          #endif
          u_xlat7 = ((u_xlat4.z * (-2)) + 3);
          u_xlat10 = (u_xlat4.z * u_xlat4.z);
          u_xlat7 = (((-u_xlat7) * u_xlat10) + 1);
          u_xlat10 = ((u_xlat4.x * (-2)) + 3);
          u_xlat4.x = (u_xlat4.x * u_xlat4.x);
          u_xlat4.x = (u_xlat4.x * u_xlat10);
          u_xlat4.x = (u_xlat7 * u_xlat4.x);
          u_xlat7 = (6.28318548 / _TimeOnDuration);
          u_xlat1.x = (u_xlat7 * u_xlat1.x);
          u_xlat7 = ((u_xlat1.x * 0.636600018) + 56.7271996);
          u_xlat1.x = sin(u_xlat1.x);
          u_xlat7 = cos(u_xlat7);
          u_xlat7 = ((u_xlat7 * 0.5) + 0.5);
          u_xlat1.x = (u_xlat7 * u_xlat1.x);
          u_xlat1.x = ((_NoiseAmount * u_xlat1.x) + (-_NoiseAmount));
          u_xlat1.x = (u_xlat1.x + 1);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb7 = (_NoiseAmount<0.00999999978);
          #else
          u_xlatb7 = (_NoiseAmount<0.00999999978);
          #endif
          u_xlat1.x = (u_xlatb7)?(u_xlat4.x):(u_xlat1.x);
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
