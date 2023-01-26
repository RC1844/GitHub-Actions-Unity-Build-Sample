Shader "UI/Image/Blur"
{
  Properties
  {
    [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
    _Color ("Tint", Color) = (1,1,1,1)
    _StencilComp ("Stencil Comparison", float) = 8
    _Stencil ("Stencil ID", float) = 0
    _StencilOp ("Stencil Operation", float) = 0
    _StencilWriteMask ("Stencil Write Mask", float) = 255
    _StencilReadMask ("Stencil Read Mask", float) = 255
    _ColorMask ("Color Mask", float) = 15
    _Distance ("Distance", Range(0, 0.1)) = 0.015
  }
  SubShader
  {
    Tags
    { 
      "CanUseSpriteAtlas" = "true"
      "IGNOREPROJECTOR" = "true"
      "PreviewType" = "Plane"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "CanUseSpriteAtlas" = "true"
        "IGNOREPROJECTOR" = "true"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
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
      Fog
      { 
        Mode  Off
      } 
      Blend SrcAlpha OneMinusSrcAlpha
      ColorMask 0
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _Color;
      uniform float _Distance;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
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
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0 = (in_v.color * _Color);
          out_v.color = u_xlat0;
          out_v.texcoord.xy = in_v.texcoord.xy;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat16_0;
      float4 u_xlat1_d;
      float4 u_xlat16_1;
      float4 u_xlat2;
      float4 u_xlat16_2;
      float4 u_xlat16_3;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat1_d.yz = (in_f.texcoord.xy + float2(_Distance, _Distance));
          u_xlat16_2 = tex2D(_MainTex, u_xlat1_d.yz);
          u_xlat2 = (u_xlat16_2 * in_f.color);
          u_xlat0_d = ((u_xlat16_0 * in_f.color) + u_xlat2);
          u_xlat2.y = in_f.texcoord.y;
          u_xlat2.x = u_xlat1_d.y;
          u_xlat16_3 = tex2D(_MainTex, u_xlat2.xy);
          u_xlat0_d = ((u_xlat16_3 * in_f.color) + u_xlat0_d);
          u_xlat1_d.y = in_f.texcoord.x;
          u_xlat16_3 = tex2D(_MainTex, u_xlat1_d.yz);
          u_xlat0_d = ((u_xlat16_3 * in_f.color) + u_xlat0_d);
          u_xlat2.zw = (in_f.texcoord.xy + (-float2(_Distance, _Distance)));
          u_xlat16_3 = tex2D(_MainTex, u_xlat2.zw);
          u_xlat0_d = ((u_xlat16_3 * in_f.color) + u_xlat0_d);
          u_xlat16_3 = tex2D(_MainTex, u_xlat2.xw);
          u_xlat0_d = ((u_xlat16_3 * in_f.color) + u_xlat0_d);
          u_xlat1_d.xw = u_xlat2.zw;
          u_xlat16_2 = tex2D(_MainTex, u_xlat1_d.xz);
          u_xlat0_d = ((u_xlat16_2 * in_f.color) + u_xlat0_d);
          u_xlat1_d.yz = in_f.texcoord.yx;
          u_xlat16_2 = tex2D(_MainTex, u_xlat1_d.xy);
          u_xlat16_1 = tex2D(_MainTex, u_xlat1_d.zw);
          u_xlat0_d = ((u_xlat16_2 * in_f.color) + u_xlat0_d);
          u_xlat0_d = ((u_xlat16_1 * in_f.color) + u_xlat0_d);
          out_f.color = (u_xlat0_d * float4(0.111111112, 0.111111112, 0.111111112, 0.111111112));
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
