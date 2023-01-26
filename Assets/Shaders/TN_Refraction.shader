Shader "TN/Refraction"
{
  Properties
  {
    [Header(TexType)] [Enum(NormalMap,0,BlackTexture,1,AlphaTexture,2)] _UWT ("UseWhichType", float) = 0
    [MaterialToggle] _UseOffsetMode ("UseOffsetMode(CustomdataXY)", float) = 0
    _NormalMap ("NormalMap", 2D) = "bump" {}
    _BlackTexture ("BlackTexture", 2D) = "white" {}
    _AlphaTexture ("AlphaTexture", 2D) = "white" {}
    _DistortIntensity ("DistortIntensity", Range(-1, 1)) = 0
    _AdjustPosZ ("Adjust Pos Z", Range(-10, 10)) = 0
    [Header(Blend Settings)] [Enum(Off,0,Front,1,Back,2)] _Cull ("CullMask", float) = 0
    [Enum(Off,0,On,1)] _ZWrite ("Zwrite", float) = 0
    [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", float) = 2
    [Header(Stencil Settings)] _Ref ("Ref", float) = 0
    [Enum(UnityEngine.Rendering.CompareFunction)] _Comp ("Comparison", float) = 0
    [Enum(UnityEngine.Rendering.StencilOp)] _Pass ("Pass ", float) = 0
    [Enum(UnityEngine.Rendering.StencilOp)] _Fail ("Fail ", float) = 0
    [Enum(UnityEngine.Rendering.StencilOp)] _ZFail ("ZFail ", float) = 0
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "Transparent"
      "RenderType" = "TN_Refraction"
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
    Pass // ind: 2, name: TN_Refraction
    {
      Name "TN_Refraction"
      Tags
      { 
        "QUEUE" = "Transparent"
        "RenderType" = "TN_Refraction"
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
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float _AdjustPosZ;
      uniform float4 _NormalMap_ST;
      uniform float4 _AlphaTexture_ST;
      uniform float4 _BlackTexture_ST;
      uniform float _DistortIntensity;
      uniform float _UWT;
      uniform float _UseOffsetMode;
      uniform sampler2D _GrabpassTex_Skill;
      uniform sampler2D _NormalMap;
      uniform sampler2D _BlackTexture;
      uniform sampler2D _AlphaTexture;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 texcoord :TEXCOORD0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float4 color :COLOR0;
          float4 texcoord2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float4 color :COLOR0;
          float4 texcoord2 :TEXCOORD2;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 phase0_Output0_1;
      float4 u_xlat0;
      float4 u_xlat1;
      float u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = UnityObjectToClipPos(in_v.vertex);
          u_xlat1.x = (_AdjustPosZ / u_xlat0.w);
          u_xlat0.z = (u_xlat0.z + u_xlat1.x);
          out_v.vertex = u_xlat0;
          out_v.texcoord2.zw = u_xlat0.zw;
          phase0_Output0_1 = in_v.texcoord;
          out_v.color = in_v.color;
          u_xlat2 = (u_xlat0.y * _ProjectionParams.x);
          u_xlat0.xz = (u_xlat0.xw * float2(0.5, 0.5));
          u_xlat0.w = (u_xlat2 * 0.5);
          out_v.texcoord2.xy = (u_xlat0.zz + u_xlat0.xw);
          out_v.texcoord = phase0_Output0_1.xy;
          out_v.texcoord1 = phase0_Output0_1.zw;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 u_xlat0_d;
      float3 u_xlat10_0;
      float2 u_xlat1_d;
      float3 u_xlat10_1;
      uint u_xlatu1;
      float2 u_xlatb1;
      float3 u_xlat10_2;
      float2 u_xlat6;
      int u_xlatb6;
      float2 u_xlat7;
      float2 u_xlat16_7;
      float2 u_xlat10_7;
      float2 u_xlatb7;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = (in_f.texcoord2.xy / in_f.texcoord2.ww);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb6 = (float4(0, 0, 0, 0).x != float4(_UseOffsetMode, _UseOffsetMode, _UseOffsetMode, _UseOffsetMode).x && float4(0, 0, 0, 0).y != float4(_UseOffsetMode, _UseOffsetMode, _UseOffsetMode, _UseOffsetMode).y && float4(0, 0, 0, 0).z != float4(_UseOffsetMode, _UseOffsetMode, _UseOffsetMode, _UseOffsetMode).z && float4(0, 0, 0, 0).w != float4(_UseOffsetMode, _UseOffsetMode, _UseOffsetMode, _UseOffsetMode).w);
          #else
          u_xlatb6 = (float4(0, 0, 0, 0).x != float4(_UseOffsetMode, _UseOffsetMode, _UseOffsetMode, _UseOffsetMode).x && float4(0, 0, 0, 0).y != float4(_UseOffsetMode, _UseOffsetMode, _UseOffsetMode, _UseOffsetMode).y && float4(0, 0, 0, 0).z != float4(_UseOffsetMode, _UseOffsetMode, _UseOffsetMode, _UseOffsetMode).z && float4(0, 0, 0, 0).w != float4(_UseOffsetMode, _UseOffsetMode, _UseOffsetMode, _UseOffsetMode).w);
          #endif
          if(u_xlatb6)
          {
              u_xlat6.xy = ((in_f.color.ww * in_f.texcoord1.xy) + u_xlat0_d.xy);
              u_xlatb1.xy = bool4(float4(0.999000013, 0.999000013, 0, 0) < u_xlat6.xyxx).xy;
              u_xlatb7.xy = bool4(u_xlat6.xyxy < float4(0.00100000005, 0.00100000005, 0.00100000005, 0.00100000005)).xy;
              u_xlatb1.x = (u_xlatb7.x || u_xlatb1.x);
              u_xlatb1.x = (u_xlatb1.y || u_xlatb1.x);
              u_xlatb1.x = (u_xlatb7.y || u_xlatb1.x);
              if(u_xlatb1.x)
              {
                  out_f.color = float4(0, 0, 0, 1);
                  return out_f;
              }
              u_xlat10_1.xyz = tex2D(_GrabpassTex_Skill, u_xlat6.xy).xyz;
              out_f.color.xyz = u_xlat10_1.xyz;
              out_f.color.w = 1;
              return out_f;
          }
          u_xlat6.xy = ((in_f.texcoord.xy * float2(2, 2)) + float2(-1, (-1)));
          u_xlatu1 = uint(_UWT);
          switch(int(int(u_xlatu1)));
          u_xlat7.xy = TRANSFORM_TEX(in_f.texcoord.xy, _NormalMap);
          u_xlat16_7.xy = tex2D(_NormalMap, u_xlat7.xy).xy;
          u_xlat7.xy = (u_xlat16_7.xy + float2(-0.5, (-0.5)));
          u_xlat1_d.xy = (u_xlat7.xy * float2(-2, 2));
          u_xlat7.xy = TRANSFORM_TEX(in_f.texcoord.xy, _BlackTexture);
          u_xlat10_7.xy = tex2D(_BlackTexture, u_xlat7.xy).xy;
          u_xlat1_d.xy = (u_xlat6.xy * u_xlat10_7.xy);
          u_xlat7.xy = TRANSFORM_TEX(in_f.texcoord.xy, _AlphaTexture);
          u_xlat10_2.xyz = tex2D(_AlphaTexture, u_xlat7.xy).xyw;
          u_xlat6.xy = (u_xlat6.xy * u_xlat10_2.xy);
          u_xlat1_d.xy = (u_xlat10_2.zz * u_xlat6.xy);
          default: ;
          u_xlat1_d.x = float(0);
          u_xlat1_d.y = float(0);
          u_xlat6.xy = (u_xlat1_d.xy * float2(_DistortIntensity, _DistortIntensity));
          u_xlat0_d.xy = ((in_f.color.ww * u_xlat6.xy) + u_xlat0_d.xy);
          u_xlat10_0.xyz = tex2D(_GrabpassTex_Skill, u_xlat0_d.xy).xyz;
          out_f.color.xyz = u_xlat10_0.xyz;
          out_f.color.w = 1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
