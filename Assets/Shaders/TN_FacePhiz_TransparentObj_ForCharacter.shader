Shader "TN/FacePhiz_TransparentObj_ForCharacter"
{
  Properties
  {
    _MainTex ("Texture", 2D) = "white" {}
    [HDR] _Color ("Color", Color) = (1,1,1,1)
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "Transparent+1"
      "RenderType" = "Opaque"
    }
    Pass // ind: 1, name: TN_FacePhiz
    {
      Name "TN_FacePhiz"
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "QUEUE" = "Transparent+1"
        "RenderType" = "Opaque"
      }
      ZWrite Off
      Cull Off
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4 _LightColor0;
      uniform float4 _Color;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
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
          out_v.vertex = u_xlat0;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat16_0;
      float4 u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0.xyz = (_LightColor0.xyz + float3(0.300000012, 0.300000012, 0.300000012));
          u_xlat16_1 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_0.xyz = (u_xlat16_0.xyz * u_xlat16_1.xyz);
          out_f.color.w = (u_xlat16_1.w * _Color.w);
          out_f.color.xyz = (u_xlat16_0.xyz * _Color.xyz);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
