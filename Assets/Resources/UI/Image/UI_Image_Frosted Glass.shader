Shader "UI/Image/Frosted Glass"
{
  Properties
  {
    _blurSizeXY ("Blur Size XY", Range(0, 10)) = 2
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
      }
      ZClip Off
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 0
        WriteMask 0
        Pass Keep
        Fail Keep
        ZFail Keep
        PassFront Keep
        FailFront Keep
        ZFailFront Keep
        PassBack Keep
        FailBack Keep
        ZFailBack Keep
      } 
      // m_ProgramMask = 0
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "QUEUE" = "Transparent"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4 _ProjectionParams;
      uniform float _blurSizeXY;
      uniform sampler2D _GrabTexture;
      struct appdata_t
      {
          float4 vertex :POSITION0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
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
          u_xlat0 = UnityObjectToClipPos(in_v.vertex);
          out_v.vertex = u_xlat0;
          out_v.texcoord = u_xlat0;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat16_0;
      float4 u_xlat1_d;
      float4 u_xlat16_1;
      int u_xlatb1;
      float4 u_xlat2;
      float4 u_xlat16_2;
      float4 u_xlat3;
      float4 u_xlat16_3;
      float3 u_xlat4;
      float4 u_xlat5;
      float4 u_xlat16_5;
      float4 u_xlat6;
      float4 u_xlat16_6;
      float u_xlat15;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d = (float4(_blurSizeXY, _blurSizeXY, _blurSizeXY, _blurSizeXY) * float4(0.00250000018, 0.00200000009, 0.00150000001, 0.000500000024));
          u_xlat1_d.xy = (in_f.texcoord.xy / in_f.texcoord.ww);
          u_xlat1_d.xy = (u_xlat1_d.xy + float2(1, 1));
          u_xlat2 = ((u_xlat1_d.xxxx * float4(0.5, 0.5, 0.5, 0.5)) + u_xlat0_d.zxwy);
          u_xlat0_d = ((u_xlat1_d.xxxx * float4(0.5, 0.5, 0.5, 0.5)) + (-u_xlat0_d.zxwy));
          u_xlat3.xz = u_xlat2.yw;
          u_xlat15 = (((-u_xlat1_d.y) * 0.5) + 1);
          u_xlat4.xy = (u_xlat1_d.xy * float2(0.5, 0.5));
          #ifdef UNITY_ADRENO_ES3
          u_xlatb1 = (_ProjectionParams.x<0);
          #else
          u_xlatb1 = (_ProjectionParams.x<0);
          #endif
          u_xlat4.z = (u_xlatb1)?(u_xlat15):(u_xlat4.y);
          u_xlat1_d = (((-float4(_blurSizeXY, _blurSizeXY, _blurSizeXY, _blurSizeXY)) * float4(0.00250000018, 0.00200000009, 0.00150000001, 0.000500000024)) + u_xlat4.zzzz);
          u_xlat3.yw = u_xlat1_d.xy;
          u_xlat2.yw = u_xlat1_d.zw;
          u_xlat16_1 = tex2D(_GrabTexture, u_xlat3.xy);
          u_xlat16_3 = tex2D(_GrabTexture, u_xlat3.zw);
          u_xlat1_d = (u_xlat16_1 * float4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004));
          u_xlat5.xz = u_xlat0_d.yw;
          u_xlat6 = ((float4(_blurSizeXY, _blurSizeXY, _blurSizeXY, _blurSizeXY) * float4(0.00250000018, 0.00200000009, 0.00150000001, 0.000500000024)) + u_xlat4.zzzz);
          u_xlat5.yw = u_xlat6.xy;
          u_xlat0_d.yw = u_xlat6.zw;
          u_xlat16_6 = tex2D(_GrabTexture, u_xlat5.xy);
          u_xlat16_5 = tex2D(_GrabTexture, u_xlat5.zw);
          u_xlat1_d = ((u_xlat16_6 * float4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004)) + u_xlat1_d);
          u_xlat1_d = ((u_xlat16_5 * float4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007)) + u_xlat1_d);
          u_xlat1_d = ((u_xlat16_3 * float4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007)) + u_xlat1_d);
          u_xlat16_3 = tex2D(_GrabTexture, u_xlat0_d.xy);
          u_xlat16_0 = tex2D(_GrabTexture, u_xlat0_d.zw);
          u_xlat1_d = ((u_xlat16_3 * float4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036)) + u_xlat1_d);
          u_xlat16_3 = tex2D(_GrabTexture, u_xlat2.xy);
          u_xlat16_2 = tex2D(_GrabTexture, u_xlat2.zw);
          u_xlat1_d = ((u_xlat16_3 * float4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036)) + u_xlat1_d);
          u_xlat3.xw = (((-float2(_blurSizeXY, _blurSizeXY)) * float2(0.00100000005, 0.00100000005)) + u_xlat4.xz);
          u_xlat3.yz = ((float2(_blurSizeXY, _blurSizeXY) * float2(0.00100000005, 0.00100000005)) + u_xlat4.zx);
          u_xlat16_5 = tex2D(_GrabTexture, u_xlat3.xy);
          u_xlat16_3 = tex2D(_GrabTexture, u_xlat3.zw);
          u_xlat1_d = ((u_xlat16_5 * float4(0.119999997, 0.119999997, 0.119999997, 0.119999997)) + u_xlat1_d);
          u_xlat1_d = ((u_xlat16_3 * float4(0.119999997, 0.119999997, 0.119999997, 0.119999997)) + u_xlat1_d);
          u_xlat0_d = ((u_xlat16_0 * float4(0.150000006, 0.150000006, 0.150000006, 0.150000006)) + u_xlat1_d);
          u_xlat0_d = ((u_xlat16_2 * float4(0.150000006, 0.150000006, 0.150000006, 0.150000006)) + u_xlat0_d);
          u_xlat1_d = (((-float4(_blurSizeXY, _blurSizeXY, _blurSizeXY, _blurSizeXY)) * float4(0.00250000018, 0.00250000018, 0.00200000009, 0.00200000009)) + u_xlat4.xzxz);
          u_xlat16_2 = tex2D(_GrabTexture, u_xlat1_d.xy);
          u_xlat16_1 = tex2D(_GrabTexture, u_xlat1_d.zw);
          u_xlat0_d = ((u_xlat16_2 * float4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004)) + u_xlat0_d);
          u_xlat0_d = ((u_xlat16_1 * float4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007)) + u_xlat0_d);
          u_xlat1_d = (((-float4(_blurSizeXY, _blurSizeXY, _blurSizeXY, _blurSizeXY)) * float4(0.00150000001, 0.00150000001, 0.000500000024, 0.000500000024)) + u_xlat4.xzxz);
          u_xlat16_2 = tex2D(_GrabTexture, u_xlat1_d.xy);
          u_xlat16_1 = tex2D(_GrabTexture, u_xlat1_d.zw);
          u_xlat0_d = ((u_xlat16_2 * float4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036)) + u_xlat0_d);
          u_xlat2.xy = (((-float2(_blurSizeXY, _blurSizeXY)) * float2(0.00100000005, 0.00100000005)) + u_xlat4.xz);
          u_xlat16_2 = tex2D(_GrabTexture, u_xlat2.xy);
          u_xlat0_d = ((u_xlat16_2 * float4(0.119999997, 0.119999997, 0.119999997, 0.119999997)) + u_xlat0_d);
          u_xlat0_d = ((u_xlat16_1 * float4(0.150000006, 0.150000006, 0.150000006, 0.150000006)) + u_xlat0_d);
          u_xlat16_1 = tex2D(_GrabTexture, u_xlat4.xz);
          u_xlat0_d = ((u_xlat16_1 * float4(0.159999996, 0.159999996, 0.159999996, 0.159999996)) + u_xlat0_d);
          u_xlat1_d = ((float4(_blurSizeXY, _blurSizeXY, _blurSizeXY, _blurSizeXY) * float4(0.00250000018, 0.00250000018, 0.00200000009, 0.00200000009)) + u_xlat4.xzxz);
          u_xlat16_2 = tex2D(_GrabTexture, u_xlat1_d.xy);
          u_xlat16_1 = tex2D(_GrabTexture, u_xlat1_d.zw);
          u_xlat0_d = ((u_xlat16_2 * float4(0.150000006, 0.150000006, 0.150000006, 0.150000006)) + u_xlat0_d);
          u_xlat0_d = ((u_xlat16_1 * float4(0.119999997, 0.119999997, 0.119999997, 0.119999997)) + u_xlat0_d);
          u_xlat1_d = ((float4(_blurSizeXY, _blurSizeXY, _blurSizeXY, _blurSizeXY) * float4(0.00150000001, 0.00150000001, 0.000500000024, 0.000500000024)) + u_xlat4.xzxz);
          u_xlat2.xy = ((float2(_blurSizeXY, _blurSizeXY) * float2(0.00100000005, 0.00100000005)) + u_xlat4.xz);
          u_xlat16_2 = tex2D(_GrabTexture, u_xlat2.xy);
          u_xlat16_3 = tex2D(_GrabTexture, u_xlat1_d.xy);
          u_xlat16_1 = tex2D(_GrabTexture, u_xlat1_d.zw);
          u_xlat0_d = ((u_xlat16_3 * float4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036)) + u_xlat0_d);
          u_xlat0_d = ((u_xlat16_2 * float4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007)) + u_xlat0_d);
          u_xlat0_d = ((u_xlat16_1 * float4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004)) + u_xlat0_d);
          out_f.color = (u_xlat0_d * float4(0.5, 0.5, 0.5, 0.5));
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
