Shader "FX/MirrorReflection"
{
  Properties
  {
    _MainTex ("Base (RGB)", 2D) = "white" {}
    [HideInInspector] _ReflectionTex ("", 2D) = "white" {}
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    LOD 100
    Pass // ind: 1, name: 
    {
      Tags
      { 
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
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform sampler2D _ReflectionTex;
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
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          u_xlat0 = UnityObjectToClipPos(in_v.vertex);
          u_xlat1.x = (u_xlat0.y * _ProjectionParams.x);
          u_xlat1.w = (u_xlat1.x * 0.5);
          u_xlat1.xz = (u_xlat0.xw * float2(0.5, 0.5));
          out_v.texcoord1.xy = (u_xlat1.zz + u_xlat1.xw);
          out_v.texcoord1.zw = u_xlat0.zw;
          out_v.vertex = u_xlat0;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 u_xlat0_d;
      float4 u_xlat16_0;
      float4 u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 hlslcc_FragCoord = float4(gl_FragCoord.xyz, (1 / gl_FragCoord.w));
          u_xlat0_d.xy = (in_f.texcoord1.xy / in_f.texcoord1.ww);
          u_xlat16_0 = tex2D(_ReflectionTex, u_xlat0_d.xy);
          u_xlat16_1 = tex2D(_MainTex, hlslcc_FragCoord.ww);
          out_f.color = (u_xlat16_0 * u_xlat16_1);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
