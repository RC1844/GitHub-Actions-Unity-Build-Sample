Shader "TN/GaussingBlur"
{
  Properties
  {
    _MainTex ("Texture", 2D) = "white" {}
    _ScreenTex ("ScreenTex", 2D) = "white" {}
    _BlurSize ("BlurSize", float) = 1
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "PreviewType" = "Plane"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: TN/GaussingBlur
    {
      Name "TN/GaussingBlur"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZTest Always
      ZWrite Off
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4 _ScreenParams;
      uniform float4 _MainTex_TexelSize;
      uniform float _BlurSize;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 SV_TARGET0 :SV_TARGET0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = UnityObjectToClipPos(in_v.vertex);
          out_v.vertex = u_xlat0;
          out_v.texcoord.xy = in_v.texcoord.xy;
          u_xlat0.y = (u_xlat0.y * _ProjectionParams.x);
          u_xlat1.xzw = (u_xlat0.xwy * float3(0.5, 0.5, 0.5));
          out_v.texcoord1.zw = u_xlat0.zw;
          out_v.texcoord1.xy = (u_xlat1.zz + u_xlat1.xw);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 ImmCB_0_0_0[9];
      float2 u_xlat0_d;
      float2 u_xlat1_d;
      float3 u_xlat2;
      float3 u_xlat16_2;
      float3 u_xlat16_3;
      float u_xlat8;
      float2 u_xlat9;
      int u_xlatb9;
      int u_xlati12;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          ImmCB_0_0_0[0] = float2(-1, (-1));
          ImmCB_0_0_0[1] = float2(0, (-1));
          ImmCB_0_0_0[2] = float2(1, (-1));
          ImmCB_0_0_0[3] = float2(-1, 0);
          ImmCB_0_0_0[4] = float2(0, 0);
          ImmCB_0_0_0[5] = float2(1, 0);
          ImmCB_0_0_0[6] = float2(-1, 1);
          ImmCB_0_0_0[7] = float2(0, 1);
          ImmCB_0_0_0[8] = float2(1, 1);
          u_xlat0_d.xy = (in_f.texcoord1.xy / in_f.texcoord1.ww);
          u_xlat8 = (_ScreenParams.x * 0.00052083336);
          u_xlat1_d.xy = (_MainTex_TexelSize.xy * float2(_BlurSize, _BlurSize));
          u_xlat16_2.x = float(0);
          u_xlat16_2.y = float(0);
          u_xlat16_2.z = float(0);
          u_xlati12 = 0;
          while(true)
          {
              #ifdef UNITY_ADRENO_ES3
              u_xlatb9 = (u_xlati12>=9);
              #else
              u_xlatb9 = (u_xlati12>=9);
              #endif
              if(u_xlatb9)
              {
                  break;
              }
              u_xlat9.xy = (u_xlat1_d.xy * ImmCB_0_0_0[u_xlati12].xy);
              u_xlat9.xy = ((u_xlat9.xy * float2(u_xlat8, u_xlat8)) + u_xlat0_d.xy);
              u_xlat16_3.xyz = tex2D(_MainTex, u_xlat9.xy).xyz;
              u_xlat2.xyz = (u_xlat16_2.xyz + u_xlat16_3.xyz);
              u_xlati12 = (u_xlati12 + 1);
              u_xlat16_2.xyz = u_xlat2.xyz;
          }
          out_f.SV_TARGET0.xyz = (u_xlat16_2.xyz * float3(0.111111112, 0.111111112, 0.111111112));
          out_f.SV_TARGET0.w = 1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
