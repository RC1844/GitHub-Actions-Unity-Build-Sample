Shader "AngryBots/FX/RainSplash"
{
  Properties
  {
    _MainTex ("Base (RGB)", 2D) = "white" {}
    _Intensity ("Intensity", Range(0.5, 4)) = 1.5
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "Transparent"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "QUEUE" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Blend One OneMinusSrcColor
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float _Intensity;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
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
      float u_xlat16_2;
      float u_xlat16_5;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = UnityObjectToClipPos(in_v.vertex);
          out_v.vertex = u_xlat0;
          u_xlat0.x = ((_Time.z * 0.5) + in_v.texcoord1.x);
          u_xlat0.x = frac(u_xlat0.x);
          u_xlat16_2 = (u_xlat0.x * 12);
          u_xlat16_5 = (((-u_xlat0.x) * 2) + 1);
          u_xlat16_5 = max(u_xlat16_5, 0);
          out_v.texcoord1 = (float4(u_xlat16_5, u_xlat16_5, u_xlat16_5, u_xlat16_5) * float4(_Intensity, _Intensity, _Intensity, _Intensity));
          u_xlat16_2 = floor(u_xlat16_2);
          u_xlat16_2 = (u_xlat16_2 * 0.166666672);
          out_v.texcoord.x = ((in_v.texcoord.x * 0.166666672) + u_xlat16_2);
          out_v.texcoord.y = in_v.texcoord.y;
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
