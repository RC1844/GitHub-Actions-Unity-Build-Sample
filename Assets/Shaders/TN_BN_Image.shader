Shader "TN/BN_Image"
{
  Properties
  {
    _MainTex ("Texture", 2D) = "white" {}
    _MainColor ("MainColor", Color) = (1,1,1,1)
    [Header(Blend Settings)] [Enum(UnityEngine.Rendering.BlendMode)] _SourceBlend ("SrcBlend", float) = 0
    [Enum(UnityEngine.Rendering.BlendMode)] _DestBlend ("DestBlend", float) = 0
    [Enum(Off,0,Front,1,Back,2)] _Cull ("CullMask", float) = 0
    [Enum(Off,0,On,1)] _ZWrite ("ZWrite", float) = 1
    [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", float) = 2
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "RenderType" = "Opaque"
      }
      ZWrite Off
      Cull Off
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      uniform float4 _MainTex_ST;
      uniform float4 _MainColor;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 color :COLOR0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float2 u_xlat0;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.texcoord.xy = u_xlat0.xy;
          out_v.vertex.xy = ((u_xlat0.xy * float2(2, 2)) + float2(-1, (-1)));
          out_v.vertex.zw = in_v.vertex.zw;
          out_v.color = in_v.color;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float3 u_xlat16_0;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0.xyz = tex2D(_MainTex, in_f.texcoord.xy).xyz;
          u_xlat0_d.xyz = (u_xlat16_0.xyz * _MainColor.xyz);
          out_f.color.xyz = (u_xlat0_d.xyz * in_f.color.xyz);
          out_f.color.w = (in_f.color.w * _MainColor.w);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
