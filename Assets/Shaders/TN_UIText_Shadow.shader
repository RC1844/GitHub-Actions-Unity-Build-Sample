Shader "TN/UIText_Shadow"
{
  Properties
  {
    [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
    _OutlineColor ("OutlineColor", Color) = (1,1,1,1)
    [HideInInspector] _OutlineWidth ("OutlineWidth", Range(0, 10)) = 0
    _ShadowColor ("ShadowColor", Color) = (1,1,1,1)
    [HideInInspector] _ShadowOffset ("ShadowOffset", Vector) = (1,-1,0,0)
    [MaterialToggle] [HideInInspector] _SoftShadow ("SoftShadow", float) = 0
    [HideInInspector] _StencilComp ("Stencil Comparison", float) = 8
    [HideInInspector] _Stencil ("Stencil ID", float) = 0
    [HideInInspector] _StencilOp ("Stencil Operation", float) = 0
    [HideInInspector] _StencilWriteMask ("Stencil Write Mask", float) = 255
    [HideInInspector] _StencilReadMask ("Stencil Read Mask", float) = 255
    [HideInInspector] _ColorMask ("Color Mask", float) = 15
    [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", float) = 0
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
    Pass // ind: 1, name: TN_UIText_Shadow
    {
      Name "TN_UIText_Shadow"
      Tags
      { 
        "CanUseSpriteAtlas" = "true"
        "IGNOREPROJECTOR" = "true"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZTest Always
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
      Blend SrcAlpha OneMinusSrcAlpha
      ColorMask 0
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _ShadowOffset;
      uniform float4 _MainTex_ST;
      //uniform float4 _ScreenParams;
      uniform float4 _ShadowColor;
      uniform float4 _ClipRect;
      uniform float4 _MainTex_TexelSize;
      uniform float _OutlineWidth;
      uniform float _SoftShadow;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float2 texcoord2 :TEXCOORD2;
      };
      
      struct OUT_Data_Vert
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float2 texcoord2 :TEXCOORD2;
          float4 texcoord3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float2 texcoord2 :TEXCOORD2;
          float4 texcoord3 :TEXCOORD3;
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
          u_xlat0.xy = (in_v.vertex.xy + _ShadowOffset.xy);
          u_xlat1 = (u_xlat0.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat1 = ((conv_mxt4x4_0(unity_ObjectToWorld) * u_xlat0.xxxx) + u_xlat1);
          out_v.texcoord3.xy = u_xlat0.xy;
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat1);
          u_xlat0 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          out_v.vertex = mul(unity_MatrixVP, u_xlat0);
          out_v.color = in_v.color;
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.texcoord1.xy = in_v.texcoord1.xy;
          out_v.texcoord2.xy = in_v.texcoord2.xy;
          out_v.texcoord3.zw = in_v.vertex.zw;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 ImmCB_0_0_0[12];
      float4 u_xlat0_d;
      float u_xlat16_0;
      float4 u_xlatb0;
      float2 u_xlat1_d;
      int u_xlati1;
      float2 u_xlatb1;
      float2 u_xlat2;
      float2 u_xlatb2;
      float u_xlat16_3;
      float2 u_xlat4;
      float2 u_xlatb4;
      float2 u_xlat5;
      float2 u_xlatb5;
      float u_xlat16_7;
      float u_xlat8;
      float u_xlat12;
      float u_xlat16_13;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          ImmCB_0_0_0[0] = float2(1, 0);
          ImmCB_0_0_0[1] = float2(0.865999997, 0.5);
          ImmCB_0_0_0[2] = float2(0.5, 0.865999997);
          ImmCB_0_0_0[3] = float2(0, 1);
          ImmCB_0_0_0[4] = float2(-0.5, 0.865999997);
          ImmCB_0_0_0[5] = float2(-0.865999997, 0.5);
          ImmCB_0_0_0[6] = float2(-1, 0);
          ImmCB_0_0_0[7] = float2(-0.865999997, (-0.5));
          ImmCB_0_0_0[8] = float2(-0.5, (-0.865999997));
          ImmCB_0_0_0[9] = float2(0, (-1));
          ImmCB_0_0_0[10] = float2(0.5, (-0.865999997));
          ImmCB_0_0_0[11] = float2(0.865999997, (-0.5));
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy).w;
          u_xlatb4.xy = bool4(in_f.texcoord.xyxx >= in_f.texcoord1.xyxx).xy;
          u_xlat4.xy = lerp(float2(0, 0), float2(1, 1), float2(u_xlatb4.xy));
          u_xlatb1.xy = bool4(in_f.texcoord2.xyxx >= in_f.texcoord.xyxx).xy;
          u_xlat1_d.xy = lerp(float2(0, 0), float2(1, 1), float2(u_xlatb1.xy));
          u_xlat4.xy = (u_xlat4.xy * u_xlat1_d.xy);
          u_xlat4.x = (u_xlat4.y * u_xlat4.x);
          u_xlat0_d.x = (u_xlat4.x * u_xlat16_0);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb4.x = (0<_OutlineWidth);
          #else
          u_xlatb4.x = (0<_OutlineWidth);
          #endif
          if(u_xlatb4.x)
          {
              u_xlat8 = (_ScreenParams.x * 0.00052083336);
              u_xlat12 = 0;
              int u_xlati_loop_1 = 0;
              while((u_xlati_loop_1<12))
              {
                  u_xlat5.xy = (float2(_OutlineWidth, _OutlineWidth) * ImmCB_0_0_0[u_xlati_loop_1].xy);
                  u_xlat5.xy = (u_xlat5.xy * _MainTex_TexelSize.xy);
                  u_xlat5.xy = ((u_xlat5.xy * float2(u_xlat8, u_xlat8)) + in_f.texcoord.xy);
                  u_xlat16_13 = tex2D(_MainTex, u_xlat5.xy).w;
                  u_xlatb2.xy = bool4(u_xlat5.xyxx >= in_f.texcoord1.xyxx).xy;
                  u_xlat2.xy = lerp(float2(0, 0), float2(1, 1), float2(u_xlatb2.xy));
                  u_xlatb5.xy = bool4(in_f.texcoord2.xyxx >= u_xlat5.xyxx).xy;
                  u_xlat5.xy = lerp(float2(0, 0), float2(1, 1), float2(u_xlatb5.xy));
                  u_xlat5.xy = (u_xlat5.xy * u_xlat2.xy);
                  u_xlat5.x = (u_xlat5.y * u_xlat5.x);
                  u_xlat12 = ((u_xlat16_13 * u_xlat5.x) + u_xlat12);
                  u_xlati_loop_1 = (u_xlati_loop_1 + 1);
              }
          }
          else
          {
              u_xlat12 = 0;
          }
          u_xlat16_3 = ((u_xlat12 * 0.125) + (-_ShadowOffset.z));
          u_xlat16_7 = ((-_ShadowOffset.z) + _ShadowOffset.w);
          u_xlat16_3 = (u_xlat16_3 / u_xlat16_7);
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_3 = min(max(u_xlat16_3, 0), 1);
          #else
          u_xlat16_3 = clamp(u_xlat16_3, 0, 1);
          #endif
          u_xlat12 = u_xlat12;
          #ifdef UNITY_ADRENO_ES3
          u_xlat12 = min(max(u_xlat12, 0), 1);
          #else
          u_xlat12 = clamp(u_xlat12, 0, 1);
          #endif
          u_xlat16_7 = ((-_SoftShadow) + 1);
          u_xlat8 = (u_xlat12 * u_xlat16_7);
          u_xlat8 = ((u_xlat16_3 * _SoftShadow) + u_xlat8);
          u_xlat12 = (u_xlatb4.x)?(1):(float(0));
          u_xlat4.x = (u_xlatb4.x)?(0):(1);
          u_xlat0_d.x = (u_xlat4.x * u_xlat0_d.x);
          u_xlat0_d.x = ((u_xlat8 * u_xlat12) + u_xlat0_d.x);
          u_xlat16_3 = (in_f.color.w * _ShadowColor.w);
          u_xlat16_3 = (u_xlat0_d.x * u_xlat16_3);
          u_xlatb0.xy = bool4(in_f.texcoord3.xyxx >= _ClipRect.xyxx).xy;
          u_xlatb0.zw = bool4(_ClipRect.zzzw >= in_f.texcoord3.xxxy).zw;
          u_xlat0_d = lerp(float4(0, 0, 0, 0), float4(1, 1, 1, 1), float4(u_xlatb0));
          u_xlat0_d.xy = (u_xlat0_d.zw * u_xlat0_d.xy);
          u_xlat0_d.x = (u_xlat0_d.y * u_xlat0_d.x);
          u_xlat0_d.x = (u_xlat0_d.x * u_xlat16_3);
          out_f.color.xyz = _ShadowColor.xyz;
          out_f.color.w = u_xlat0_d.x;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: TN_UIText_Outline
    {
      Name "TN_UIText_Outline"
      Tags
      { 
        "CanUseSpriteAtlas" = "true"
        "IGNOREPROJECTOR" = "true"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZTest Always
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
      uniform float4 _MainTex_ST;
      //uniform float4 _ScreenParams;
      uniform float4 _OutlineColor;
      uniform float4 _ClipRect;
      uniform float4 _MainTex_TexelSize;
      uniform float _OutlineWidth;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float2 texcoord2 :TEXCOORD2;
      };
      
      struct OUT_Data_Vert
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float2 texcoord2 :TEXCOORD2;
          float4 texcoord3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float2 texcoord2 :TEXCOORD2;
          float4 texcoord3 :TEXCOORD3;
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
          out_v.color = in_v.color;
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.texcoord1.xy = in_v.texcoord1.xy;
          out_v.texcoord2.xy = in_v.texcoord2.xy;
          out_v.texcoord3 = in_v.vertex;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 ImmCB_0_0_0[12];
      float4 u_xlat0_d;
      float u_xlat16_0;
      float4 u_xlatb0;
      float4 u_xlat1_d;
      int u_xlati1;
      float2 u_xlatb1;
      float2 u_xlat2;
      float2 u_xlatb2;
      float3 u_xlat16_3;
      float2 u_xlat4;
      float2 u_xlatb4;
      float2 u_xlat5;
      float2 u_xlatb5;
      float u_xlat8;
      float u_xlat12;
      float u_xlat16_13;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          ImmCB_0_0_0[0] = float2(1, 0);
          ImmCB_0_0_0[1] = float2(0.865999997, 0.5);
          ImmCB_0_0_0[2] = float2(0.5, 0.865999997);
          ImmCB_0_0_0[3] = float2(0, 1);
          ImmCB_0_0_0[4] = float2(-0.5, 0.865999997);
          ImmCB_0_0_0[5] = float2(-0.865999997, 0.5);
          ImmCB_0_0_0[6] = float2(-1, 0);
          ImmCB_0_0_0[7] = float2(-0.865999997, (-0.5));
          ImmCB_0_0_0[8] = float2(-0.5, (-0.865999997));
          ImmCB_0_0_0[9] = float2(0, (-1));
          ImmCB_0_0_0[10] = float2(0.5, (-0.865999997));
          ImmCB_0_0_0[11] = float2(0.865999997, (-0.5));
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy).w;
          u_xlatb4.xy = bool4(in_f.texcoord.xyxx >= in_f.texcoord1.xyxx).xy;
          u_xlat4.xy = lerp(float2(0, 0), float2(1, 1), float2(u_xlatb4.xy));
          u_xlatb1.xy = bool4(in_f.texcoord2.xyxx >= in_f.texcoord.xyxx).xy;
          u_xlat1_d.xy = lerp(float2(0, 0), float2(1, 1), float2(u_xlatb1.xy));
          u_xlat4.xy = (u_xlat4.xy * u_xlat1_d.xy);
          u_xlat4.x = (u_xlat4.y * u_xlat4.x);
          u_xlat0_d.x = (u_xlat4.x * u_xlat16_0);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb4.x = (0<_OutlineWidth);
          #else
          u_xlatb4.x = (0<_OutlineWidth);
          #endif
          if(u_xlatb4.x)
          {
              u_xlat8 = (_ScreenParams.x * 0.00052083336);
              u_xlat12 = 0;
              int u_xlati_loop_1 = 0;
              while((u_xlati_loop_1<12))
              {
                  u_xlat5.xy = (float2(_OutlineWidth, _OutlineWidth) * ImmCB_0_0_0[u_xlati_loop_1].xy);
                  u_xlat5.xy = (u_xlat5.xy * _MainTex_TexelSize.xy);
                  u_xlat5.xy = ((u_xlat5.xy * float2(u_xlat8, u_xlat8)) + in_f.texcoord.xy);
                  u_xlat16_13 = tex2D(_MainTex, u_xlat5.xy).w;
                  u_xlatb2.xy = bool4(u_xlat5.xyxx >= in_f.texcoord1.xyxx).xy;
                  u_xlat2.xy = lerp(float2(0, 0), float2(1, 1), float2(u_xlatb2.xy));
                  u_xlatb5.xy = bool4(in_f.texcoord2.xyxx >= u_xlat5.xyxx).xy;
                  u_xlat5.xy = lerp(float2(0, 0), float2(1, 1), float2(u_xlatb5.xy));
                  u_xlat5.xy = (u_xlat5.xy * u_xlat2.xy);
                  u_xlat5.x = (u_xlat5.y * u_xlat5.x);
                  u_xlat12 = ((u_xlat16_13 * u_xlat5.x) + u_xlat12);
                  u_xlati_loop_1 = (u_xlati_loop_1 + 1);
              }
          }
          else
          {
              u_xlat12 = 0;
          }
          u_xlat12 = u_xlat12;
          #ifdef UNITY_ADRENO_ES3
          u_xlat12 = min(max(u_xlat12, 0), 1);
          #else
          u_xlat12 = clamp(u_xlat12, 0, 1);
          #endif
          u_xlat8 = (u_xlat12 * _OutlineColor.w);
          u_xlat1_d.xyz = (in_f.color.xyz + (-_OutlineColor.xyz));
          u_xlat1_d.xyz = ((u_xlat0_d.xxx * u_xlat1_d.xyz) + _OutlineColor.xyz);
          u_xlat12 = (u_xlatb4.x)?(1):(float(0));
          u_xlat16_3.xyz = (u_xlatb4.x)?(float3(0, 0, 0)):(in_f.color.xyz);
          u_xlat1_d.xyz = ((u_xlat1_d.xyz * float3(u_xlat12, u_xlat12, u_xlat12)) + u_xlat16_3.xyz);
          u_xlat4.x = (u_xlatb4.x)?(0):(1);
          u_xlat0_d.x = (u_xlat4.x * u_xlat0_d.x);
          u_xlat0_d.x = ((u_xlat8 * u_xlat12) + u_xlat0_d.x);
          u_xlat16_3.x = (u_xlat0_d.x * in_f.color.w);
          u_xlatb0.xy = bool4(in_f.texcoord3.xyxx >= _ClipRect.xyxx).xy;
          u_xlatb0.zw = bool4(_ClipRect.zzzw >= in_f.texcoord3.xxxy).zw;
          u_xlat0_d = lerp(float4(0, 0, 0, 0), float4(1, 1, 1, 1), float4(u_xlatb0));
          u_xlat0_d.xy = (u_xlat0_d.zw * u_xlat0_d.xy);
          u_xlat0_d.x = (u_xlat0_d.y * u_xlat0_d.x);
          u_xlat1_d.w = (u_xlat0_d.x * u_xlat16_3.x);
          out_f.color = u_xlat1_d;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
