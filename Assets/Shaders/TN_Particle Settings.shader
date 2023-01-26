Shader "TN/Particle Settings"
{
  Properties
  {
    [Header(Properties)] _X_Speed ("X_Speed", float) = 0
    _Y_Speed ("Y_Speed", float) = 0
    [MaterialToggle] _SceneUV ("SceneUV", float) = 0
    _AdjPos ("AdjPos", Range(-1, 1)) = 0
    [Header(MainTex)] _MainTex ("MainTex", 2D) = "white" {}
    [HDR] _MainColor ("MainColor", Color) = (0.5,0.5,0.5,1)
    [Header(Fresnel for 3dObj)] [MaterialToggle] _Fresnel ("Fresnel", float) = 0
    _Fresnel_Range ("Fresnel_Range", Range(0, 5)) = 1
    _Fresnel_Intensity ("Fresnel_Intensity", Range(0, 5)) = 1
    [HDR] _Fresnel_Color ("Fresnel_Color", Color) = (0.5,0.5,0.5,1)
    [Header(VertexOffset)] [MaterialToggle] _UseOffset ("VertexOffset", float) = 0
    _OffsetTex ("OffsetTex", 2D) = "white" {}
    _OffsetX ("OffsetX", float) = 0
    _OffsetY ("OffsetY", float) = 0
    _OffsetIntensity ("OffsetIntensity", float) = 0
    [Header(Blend Settings)] [Enum(Max,0,Min,1,Sub,2,RevSub,3,Add,4)] _BlendOp ("BlendOp", float) = 0
    [Enum(UnityEngine.Rendering.BlendMode)] _SourceBlend ("SrcBlend", float) = 5
    [Enum(UnityEngine.Rendering.BlendMode)] _DestBlend ("DestBlend", float) = 10
    [Enum(Off,0,Front,1,Back,2)] _Cull ("CullMask", float) = 2
    [Enum(Off,0,On,1)] _ZWrite ("Zwrite", float) = 0
    [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", float) = 2
    [Header(Interupte UV)] [MaterialToggle] _InterupteToggle ("InterupteToggle", float) = 0
    _InterupteTex ("interupteTex", 2D) = "white" {}
    _InterupteValue ("interupteValue", Range(0, 1)) = 0
    [Header(Desaturate)] [MaterialToggle] _desaturate ("Desaturate", float) = 0
    [HDR] _desaturateColor ("DesaturateColor", Color) = (1,1,1,1)
    [Header(ReColor_Gradient)] [MaterialToggle] _colorGradient ("ColorGradient", float) = 0
    _GradientValue ("GradientValue", Range(0, 1)) = 0.5
    [HDR] _color1 ("BrightColor", Color) = (1,1,1,1)
    [HDR] _color2 ("DarkColor", Color) = (0.5,0.5,0.5,1)
    [Header(UV Rotator)] [MaterialToggle] _UseUVRotator ("UseUVRotator", float) = 0
    _UVRotator_Angle ("Rotator", float) = 0
    [Header(FaceColor)] [MaterialToggle] _UseFacing ("UseFacing?", float) = 0
    [HDR] _BackColor ("BackColor", Color) = (0.5,0.5,0.5,1)
    [Header(Alpha Tex(Need UV0 Custom.z))] [MaterialToggle] _UseAlphaTex ("UseAlphaTex?", float) = 0
    _AlphaTexture ("AlphaTexture", 2D) = "white" {}
    [Header(Alpha Line(Need UV0 Custom.z))] [MaterialToggle] _UseLineAlpha ("UseLineAlpha?", float) = 0
    [MaterialToggle] _TurnAroundAlpha ("TurnAroundAlpha", float) = 0
    _AlphaSpace ("AlphaSpace", float) = 10
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
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "TN_Particle"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "FORWARDBASE"
        "QUEUE" = "Transparent"
        "RenderType" = "TN_Particle"
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
      Blend Zero Zero
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
      //uniform float4 _Time;
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _OffsetTex_ST;
      uniform float _SceneUV;
      uniform float _UseOffset;
      uniform float _OffsetIntensity;
      uniform float _AdjPos;
      uniform float _OffsetX;
      uniform float _OffsetY;
      uniform sampler2D _OffsetTex;
      //uniform float3 _WorldSpaceCameraPos;
      uniform float4 _InterupteTex_ST;
      uniform float4 _MainTex_ST;
      uniform float4 _AlphaTexture_ST;
      uniform float _Fresnel_Range;
      uniform float _Fresnel_Intensity;
      uniform float _Fresnel;
      uniform float _InterupteValue;
      uniform float _InterupteToggle;
      uniform float _desaturate;
      uniform float _colorGradient;
      uniform float _GradientValue;
      uniform float _UseFacing;
      uniform float _UseUVRotator;
      uniform float _UVRotator_Angle;
      uniform float _UseAlphaTex;
      uniform float _UseLineAlpha;
      uniform float _TurnAroundAlpha;
      uniform float _AlphaSpace;
      uniform float4 _MainColor;
      uniform float4 _Fresnel_Color;
      uniform float4 _desaturateColor;
      uniform float4 _color1;
      uniform float4 _color2;
      uniform float4 _BackColor;
      uniform float _X_Speed;
      uniform float _Y_Speed;
      uniform sampler2D _InterupteTex;
      uniform sampler2D _MainTex;
      uniform sampler2D _AlphaTexture;
      struct appdata_t
      {
          float4 texcoord :TEXCOORD0;
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
          float4 color :COLOR0;
          float4 texcoord3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
          float4 color :COLOR0;
          float4 texcoord3 :TEXCOORD3;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float3 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float3 u_xlat16_2;
      float4 u_xlat3;
      float u_xlat16_4;
      float u_xlat6;
      float u_xlat13;
      float u_xlat15;
      int u_xlatb15;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.x = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat0.y = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat0.z = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat0.xyz = normalize(u_xlat0.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb15 = (float4(0, 0, 0, 0).x != float4(_UseOffset, _UseOffset, _UseOffset, _UseOffset).x && float4(0, 0, 0, 0).y != float4(_UseOffset, _UseOffset, _UseOffset, _UseOffset).y && float4(0, 0, 0, 0).z != float4(_UseOffset, _UseOffset, _UseOffset, _UseOffset).z && float4(0, 0, 0, 0).w != float4(_UseOffset, _UseOffset, _UseOffset, _UseOffset).w);
          #else
          u_xlatb15 = (float4(0, 0, 0, 0).x != float4(_UseOffset, _UseOffset, _UseOffset, _UseOffset).x && float4(0, 0, 0, 0).y != float4(_UseOffset, _UseOffset, _UseOffset, _UseOffset).y && float4(0, 0, 0, 0).z != float4(_UseOffset, _UseOffset, _UseOffset, _UseOffset).z && float4(0, 0, 0, 0).w != float4(_UseOffset, _UseOffset, _UseOffset, _UseOffset).w);
          #endif
          if(u_xlatb15)
          {
              u_xlat1.xy = (_Time.yy * float2(_OffsetX, _OffsetY));
              u_xlat1.xy = ((u_xlat1.xy * _OffsetTex_ST.xy) + in_v.texcoord.xy);
              u_xlat1.xy = (u_xlat1.xy + _OffsetTex_ST.zw);
              u_xlat1.xyz = tex2Dlod(_OffsetTex, float4(float3(u_xlat1.xy, 0), 0)).xyz;
              u_xlat16_2.x = dot(in_v.normal.xyz, in_v.normal.xyz);
              u_xlat16_2.x = rsqrt(u_xlat16_2.x);
              u_xlat16_2.xyz = (u_xlat16_2.xxx * in_v.normal.xyz);
              u_xlat16_2.xyz = (u_xlat1.xyz * u_xlat16_2.xyz);
              u_xlat16_2.xyz = ((u_xlat16_2.xyz * float3(float3(_OffsetIntensity, _OffsetIntensity, _OffsetIntensity))) + in_v.vertex.xyz);
          }
          else
          {
              u_xlat16_2.xyz = in_v.vertex.xyz;
          }
          u_xlat1 = (u_xlat16_2.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat1 = ((conv_mxt4x4_0(unity_ObjectToWorld) * u_xlat16_2.xxxx) + u_xlat1);
          u_xlat1 = ((conv_mxt4x4_2(unity_ObjectToWorld) * u_xlat16_2.zzzz) + u_xlat1);
          u_xlat2 = (u_xlat1 + conv_mxt4x4_3(unity_ObjectToWorld));
          u_xlat3 = mul(unity_MatrixVP, u_xlat2);
          u_xlat16_4 = (_AdjPos / u_xlat3.w);
          out_v.vertex.z = (u_xlat3.z + (-u_xlat16_4));
          out_v.texcoord = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat1);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb15 = (float4(0, 0, 0, 0).x != float4(_SceneUV, _SceneUV, _SceneUV, _SceneUV).x && float4(0, 0, 0, 0).y != float4(_SceneUV, _SceneUV, _SceneUV, _SceneUV).y && float4(0, 0, 0, 0).z != float4(_SceneUV, _SceneUV, _SceneUV, _SceneUV).z && float4(0, 0, 0, 0).w != float4(_SceneUV, _SceneUV, _SceneUV, _SceneUV).w);
          #else
          u_xlatb15 = (float4(0, 0, 0, 0).x != float4(_SceneUV, _SceneUV, _SceneUV, _SceneUV).x && float4(0, 0, 0, 0).y != float4(_SceneUV, _SceneUV, _SceneUV, _SceneUV).y && float4(0, 0, 0, 0).z != float4(_SceneUV, _SceneUV, _SceneUV, _SceneUV).z && float4(0, 0, 0, 0).w != float4(_SceneUV, _SceneUV, _SceneUV, _SceneUV).w);
          #endif
          u_xlat1.xz = (u_xlat3.xw * float2(0.5, 0.5));
          u_xlat6 = (u_xlat3.y * _ProjectionParams.x);
          u_xlat1.w = (u_xlat6 * 0.5);
          u_xlat1.xy = (u_xlat1.zz + u_xlat1.xw);
          u_xlat13 = (u_xlat2.y * conv_mxt4x4_1(unity_MatrixV).z);
          u_xlat13 = ((conv_mxt4x4_0(unity_MatrixV).z * u_xlat2.x) + u_xlat13);
          u_xlat13 = ((conv_mxt4x4_2(unity_MatrixV).z * u_xlat2.z) + u_xlat13);
          u_xlat13 = ((conv_mxt4x4_3(unity_MatrixV).z * u_xlat2.w) + u_xlat13);
          u_xlat1.z = (-u_xlat13);
          u_xlat1.w = u_xlat3.w;
          out_v.texcoord2 = (int(u_xlatb15))?(u_xlat1):(in_v.texcoord);
          out_v.vertex.xyw = u_xlat3.xyw;
          out_v.color = in_v.color;
          out_v.texcoord1.xyz = u_xlat0.xyz;
          out_v.texcoord3 = in_v.texcoord;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlatb0;
      float3 u_xlat16_1;
      float4 u_xlat16_2_d;
      float3 u_xlat3_d;
      float3 u_xlat10_3;
      float2 u_xlatb3;
      float2 u_xlat4;
      float3 u_xlat16_4_d;
      float u_xlat5;
      float3 u_xlat16_6;
      float3 u_xlat16_7;
      float2 u_xlat16_20;
      float u_xlat25;
      float u_xlat16_25;
      float u_xlat27;
      float u_xlat16_28;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlatb0.xy = bool4(float4(0, 0, 0, 0) != float4(_UseFacing, _UseUVRotator, _UseFacing, _UseFacing)).xy;
          u_xlat16_1.xyz = ((uint((gl_FrontFacing)?(4294967295):(uint(0)))!=uint(0)))?(_BackColor.xyz):(float3(1, 1, 1));
          u_xlat16_1.xyz = (u_xlatb0.x)?(u_xlat16_1.xyz):(float3(1, 1, 1));
          u_xlat16_2_d.xy = (in_f.texcoord2.xy / in_f.texcoord2.ww);
          u_xlatb0.xzw = bool4(float4(0, 0, 0, 0) != float4(_InterupteToggle, _InterupteToggle, _desaturate, _colorGradient)).xzw;
          if(u_xlatb0.x)
          {
              u_xlat3_d.xy = ((float2(_X_Speed, _Y_Speed) * _Time.yy) + u_xlat16_2_d.xy);
              u_xlat16_4_d.xy = TRANSFORM_TEX(u_xlat3_d.xy, _InterupteTex);
              u_xlat10_3.xy = tex2D(_InterupteTex, u_xlat16_4_d.xy).xy;
              u_xlat16_4_d.xy = ((-u_xlat16_2_d.xy) + u_xlat10_3.xy);
              u_xlat16_4_d.xy = ((float2(_InterupteValue, _InterupteValue) * u_xlat16_4_d.xy) + u_xlat16_2_d.xy);
          }
          else
          {
              u_xlat4.xy = ((float2(_X_Speed, _Y_Speed) * _Time.yy) + u_xlat16_2_d.xy);
              u_xlat16_4_d.xy = u_xlat4.xy;
          }
          u_xlat3_d.x = (_Time.y * _UVRotator_Angle);
          u_xlat5 = cos(u_xlat3_d.x);
          u_xlat3_d.x = sin(u_xlat3_d.x);
          u_xlat16_20.xy = (u_xlat16_4_d.xy + float2(-0.5, (-0.5)));
          u_xlat3_d.y = u_xlat5;
          u_xlat16_6.x = dot(u_xlat16_20.yx, u_xlat3_d.xy);
          u_xlat3_d.x = (-u_xlat3_d.x);
          u_xlat16_6.y = dot(u_xlat16_20.xy, u_xlat3_d.xy);
          u_xlat16_20.xy = (u_xlat16_6.xy + float2(0.5, 0.5));
          u_xlat16_4_d.xy = (u_xlatb0.y)?(u_xlat16_20.xy):(u_xlat16_4_d.xy);
          u_xlat16_4_d.xy = TRANSFORM_TEX(u_xlat16_4_d.xy, _MainTex);
          u_xlat16_2_d = tex2D(_MainTex, u_xlat16_4_d.xy);
          u_xlat16_25 = dot(u_xlat16_2_d.xyz, float3(0.300000012, 0.589999974, 0.109999999));
          u_xlat16_4_d.xyz = (float3(u_xlat16_25, u_xlat16_25, u_xlat16_25) * _desaturateColor.xyz);
          u_xlat16_4_d.xyz = (u_xlatb0.z)?(u_xlat16_4_d.xyz):(u_xlat16_2_d.xyz);
          u_xlat16_25 = (u_xlat16_4_d.x + (-_GradientValue));
          u_xlat16_28 = ((-_GradientValue) + 1);
          u_xlat16_25 = (u_xlat16_25 / u_xlat16_28);
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_25 = min(max(u_xlat16_25, 0), 1);
          #else
          u_xlat16_25 = clamp(u_xlat16_25, 0, 1);
          #endif
          u_xlat16_6.xyz = (float3(u_xlat16_25, u_xlat16_25, u_xlat16_25) * u_xlat16_4_d.xyz);
          u_xlat16_25 = ((-u_xlat16_25) + 1);
          u_xlat16_7.xyz = (float3(u_xlat16_25, u_xlat16_25, u_xlat16_25) * u_xlat16_4_d.xyz);
          u_xlat16_7.xyz = (u_xlat16_7.xyz * _color2.xyz);
          u_xlat16_6.xyz = ((u_xlat16_6.xyz * _color1.xyz) + u_xlat16_7.xyz);
          u_xlat16_4_d.xyz = (u_xlatb0.w)?(u_xlat16_6.xyz):(u_xlat16_4_d.xyz);
          u_xlat16_25 = (u_xlat16_2_d.w * in_f.color.w);
          u_xlatb3.xy = bool4(float4(0, 0, 0, 0) != float4(_UseAlphaTex, _UseLineAlpha, _UseAlphaTex, _UseAlphaTex)).xy;
          if(u_xlatb3.x)
          {
              u_xlat3_d.xz = TRANSFORM_TEX(in_f.texcoord3.xy, _AlphaTexture);
              u_xlat10_3.xz = tex2D(_AlphaTexture, u_xlat3_d.xz).xw;
              u_xlat3_d.x = ((u_xlat10_3.x * u_xlat10_3.z) + in_f.texcoord3.z);
              #ifdef UNITY_ADRENO_ES3
              u_xlat3_d.x = min(max(u_xlat3_d.x, 0), 1);
              #else
              u_xlat3_d.x = clamp(u_xlat3_d.x, 0, 1);
              #endif
              u_xlat25 = (u_xlat16_25 * u_xlat3_d.x);
              u_xlat16_25 = u_xlat25;
          }
          #ifdef UNITY_ADRENO_ES3
          u_xlatb3.x = (float4(0, 0, 0, 0).x != float4(_TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha).x && float4(0, 0, 0, 0).y != float4(_TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha).y && float4(0, 0, 0, 0).z != float4(_TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha).z && float4(0, 0, 0, 0).w != float4(_TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha).w);
          #else
          u_xlatb3.x = (float4(0, 0, 0, 0).x != float4(_TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha).x && float4(0, 0, 0, 0).y != float4(_TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha).y && float4(0, 0, 0, 0).z != float4(_TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha).z && float4(0, 0, 0, 0).w != float4(_TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha, _TurnAroundAlpha).w);
          #endif
          u_xlat3_d.x = (u_xlatb3.x)?(in_f.texcoord3.y):(in_f.texcoord3.x);
          u_xlat3_d.x = (u_xlat3_d.x + in_f.texcoord3.z);
          u_xlat3_d.x = (u_xlat3_d.x * 3.1400001);
          u_xlat3_d.x = sin(u_xlat3_d.x);
          u_xlat3_d.x = max(u_xlat3_d.x, 0);
          u_xlat3_d.x = log2(u_xlat3_d.x);
          u_xlat3_d.x = (u_xlat3_d.x * _AlphaSpace);
          u_xlat3_d.x = exp2(u_xlat3_d.x);
          u_xlat16_25 = (u_xlatb3.y)?(u_xlat3_d.x):(u_xlat16_25);
          u_xlat16_4_d.xyz = (u_xlat16_4_d.xyz * _MainColor.xyz);
          u_xlat16_4_d.xyz = (u_xlat16_4_d.xyz * in_f.color.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb3.x = (float4(0, 0, 0, 0).x != float4(_Fresnel, _Fresnel, _Fresnel, _Fresnel).x && float4(0, 0, 0, 0).y != float4(_Fresnel, _Fresnel, _Fresnel, _Fresnel).y && float4(0, 0, 0, 0).z != float4(_Fresnel, _Fresnel, _Fresnel, _Fresnel).z && float4(0, 0, 0, 0).w != float4(_Fresnel, _Fresnel, _Fresnel, _Fresnel).w);
          #else
          u_xlatb3.x = (float4(0, 0, 0, 0).x != float4(_Fresnel, _Fresnel, _Fresnel, _Fresnel).x && float4(0, 0, 0, 0).y != float4(_Fresnel, _Fresnel, _Fresnel, _Fresnel).y && float4(0, 0, 0, 0).z != float4(_Fresnel, _Fresnel, _Fresnel, _Fresnel).z && float4(0, 0, 0, 0).w != float4(_Fresnel, _Fresnel, _Fresnel, _Fresnel).w);
          #endif
          if(u_xlatb3.x)
          {
              u_xlat16_6.xyz = normalize(in_f.texcoord1.xyz);
              u_xlat3_d.xyz = ((-in_f.texcoord.xyz) + _WorldSpaceCameraPos.xyz);
              u_xlat3_d.xyz = normalize(u_xlat3_d.xyz);
              u_xlat16_28 = dot(u_xlat3_d.xyz, u_xlat16_6.xyz);
              u_xlat16_28 = max(u_xlat16_28, 0);
              u_xlat16_28 = ((-u_xlat16_28) + 1);
              u_xlat16_28 = log2(u_xlat16_28);
              u_xlat16_28 = (u_xlat16_28 * _Fresnel_Range);
              u_xlat16_28 = exp2(u_xlat16_28);
              u_xlat16_6.xyz = (float3(u_xlat16_28, u_xlat16_28, u_xlat16_28) * _Fresnel_Color.xyz);
              u_xlat16_6.xyz = (u_xlat16_6.xyz * float3(float3(_Fresnel_Intensity, _Fresnel_Intensity, _Fresnel_Intensity)));
              u_xlat16_6.xyz = ((u_xlat16_6.xyz * in_f.color.www) + u_xlat16_4_d.xyz);
              out_f.color.xyz = (u_xlat16_1.xyz * u_xlat16_6.xyz);
              out_f.color.w = (u_xlat16_25 * u_xlat16_28);
              return out_f;
          }
          else
          {
              out_f.color.xyz = (u_xlat16_1.xyz * u_xlat16_4_d.xyz);
              out_f.color.w = u_xlat16_25;
              return out_f;
          }
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
