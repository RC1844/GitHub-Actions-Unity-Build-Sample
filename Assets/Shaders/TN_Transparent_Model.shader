Shader "TN/Transparent_Model"
{
  Properties
  {
    _MainTex ("Texture", 2D) = "white" {}
    [HDR] _MainColor ("Color", Color) = (1,1,1,1)
    [Header(Stencil Settings)] [Space] [Space] _Ref ("Ref", float) = 0
    [Enum(UnityEngine.Rendering.CompareFunction)] _Comp ("Comparison", float) = 0
    [Enum(UnityEngine.Rendering.StencilOp)] _Pass ("Pass ", float) = 0
    [Enum(UnityEngine.Rendering.StencilOp)] _Fail ("Fail ", float) = 0
    [Enum(UnityEngine.Rendering.StencilOp)] _ZFail ("ZFail ", float) = 0
    [Header(Blend Settings)] [Enum(UnityEngine.Rendering.BlendMode)] _SourceBlend ("SrcBlend", float) = 0
    [Enum(UnityEngine.Rendering.BlendMode)] _DestBlend ("DestBlend", float) = 0
    [Enum(Off,0,Front,1,Back,2)] _Cull ("CullMask", float) = 0
    [Enum(Off,0,On,1)] _ZWrite ("Zwrite", float) = 0
    [Enum(Less,0, Greater,1, LEqual,2, GEqual,3, Equal,4, NotEqual,5, Always,6)] _ZTest ("ZTest", float) = 2
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
      Stencil
      { 
        Ref 0
        ReadMask 255
        WriteMask 255
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
      Blend Zero Zero
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
      uniform float4 _MainColor;
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
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat16_0;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat0_d = (u_xlat16_0 * _MainColor);
          out_f.color = u_xlat0_d;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
