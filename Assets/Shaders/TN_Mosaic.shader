Shader "TN/Mosaic"
{
  Properties
  {
    _MainTex ("MainTex", 2D) = "white" {}
    _MosaicIntensity ("MosaicIntensity", Range(1, 1000)) = 200
    [Header(Blend Settings)] [Enum(Off,0,Front,1,Back,2)] _Cull ("CullMask", float) = 0
    [Enum(Off,0,On,1)] _ZWrite ("ZWrite", float) = 1
    [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", float) = 2
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
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
        "RenderType" = "Transparent"
      }
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
      Blend SrcAlpha OneMinusSrcAlpha
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
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float _MosaicIntensity;
      uniform sampler2D _MainTex;
      uniform sampler2D MosaicGrab;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 color :COLOR0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = mul(unity_ObjectToWorld, float4(in_v.vertex.xyz,1.0));
          u_xlat1 = mul(unity_MatrixVP, u_xlat0);
          out_v.vertex = u_xlat1;
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          u_xlat2 = (u_xlat0.y * conv_mxt4x4_1(unity_MatrixV).z);
          u_xlat0.x = ((conv_mxt4x4_0(unity_MatrixV).z * u_xlat0.x) + u_xlat2);
          u_xlat0.x = ((conv_mxt4x4_2(unity_MatrixV).z * u_xlat0.z) + u_xlat0.x);
          u_xlat0.x = ((conv_mxt4x4_3(unity_MatrixV).z * u_xlat0.w) + u_xlat0.x);
          out_v.texcoord1.z = (-u_xlat0.x);
          u_xlat0.x = (u_xlat1.y * _ProjectionParams.x);
          u_xlat0.w = (u_xlat0.x * 0.5);
          u_xlat0.xz = (u_xlat1.xw * float2(0.5, 0.5));
          out_v.texcoord1.w = u_xlat1.w;
          out_v.texcoord1.xy = (u_xlat0.zz + u_xlat0.xw);
          out_v.color = in_v.color;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 u_xlat0_d;
      float3 u_xlat16_0;
      float u_xlat10_0;
      float u_xlat16_1;
      float u_xlat4;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = (in_f.texcoord1.xy / in_f.texcoord1.ww);
          u_xlat0_d.xy = (u_xlat0_d.xy * float2(_MosaicIntensity, _MosaicIntensity));
          u_xlat0_d.xy = floor(u_xlat0_d.xy);
          u_xlat4 = (_MosaicIntensity + (-1));
          u_xlat0_d.xy = (u_xlat0_d.xy / float2(u_xlat4, u_xlat4));
          u_xlat16_0.xyz = tex2D(MosaicGrab, u_xlat0_d.xy).xyz;
          out_f.color.xyz = (u_xlat16_0.xyz * in_f.color.xyz);
          u_xlat10_0 = tex2D(_MainTex, in_f.texcoord.xy).w;
          u_xlat16_1 = (u_xlat10_0 * in_f.color.w);
          out_f.color.w = u_xlat16_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
