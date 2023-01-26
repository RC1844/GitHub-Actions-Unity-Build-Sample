Shader "Dissolve/Dissolve_TexturCoords"
{
  Properties
  {
    _Color ("Main Color", Color) = (1,1,1,1)
    _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
    _Shininess ("Shininess", Range(0.03, 1)) = 0.078125
    _Amount ("Amount", Range(0, 1)) = 0.5
    _StartAmount ("StartAmount", float) = 0.1
    _Illuminate ("Illuminate", Range(0, 1)) = 0.5
    _Tile ("Tile", float) = 1
    _DissColor ("DissColor", Color) = (1,1,1,1)
    _ColorAnimate ("ColorAnimate", Vector) = (1,1,1,1)
    _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
    _DissolveSrcBump ("DissolveSrcBump", 2D) = "white" {}
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    LOD 400
    Pass // ind: 1, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      LOD 400
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile DIRECTIONAL
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
      //uniform float4x4 unity_WorldToObject;
      //uniform float4 unity_WorldTransformParams;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4 DissolveSrc_ST;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _WorldSpaceLightPos0;
      uniform float4 _LightColor0;
      uniform float4 _SpecColor;
      uniform float4 _Color;
      uniform float4 _DissColor;
      uniform float _Shininess;
      uniform float _Amount;
      uniform float4 _ColorAnimate;
      uniform float _Illuminate;
      uniform float _Tile;
      uniform float _StartAmount;
      uniform sampler2D _MainTex;
      uniform sampler2D _DissolveSrcBump;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 tangent :TANGENT0;
          float3 normal :NORMAL0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
          float4 texcoord3 :TEXCOORD3;
          float4 texcoord6 :TEXCOORD6;
          float4 texcoord7 :TEXCOORD7;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
          float4 texcoord3 :TEXCOORD3;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float3 u_xlat3;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          u_xlat0.xyz = ((conv_mxt4x4_3(unity_ObjectToWorld).xyz * in_v.vertex.www) + u_xlat0.xyz);
          out_v.vertex = mul(unity_MatrixVP, u_xlat1);
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.texcoord.zw = TRANSFORM_TEX(in_v.texcoord.xy, DissolveSrc);
          out_v.texcoord1.w = u_xlat0.x;
          u_xlat1.y = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat1.z = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat1.x = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
          u_xlat0.x = rsqrt(u_xlat0.x);
          u_xlat1.xyz = (u_xlat0.xxx * u_xlat1.xyz);
          u_xlat2.xyz = (in_v.tangent.yyy * conv_mxt4x4_1(unity_ObjectToWorld).yzx);
          u_xlat2.xyz = ((conv_mxt4x4_0(unity_ObjectToWorld).yzx * in_v.tangent.xxx) + u_xlat2.xyz);
          u_xlat2.xyz = ((conv_mxt4x4_2(unity_ObjectToWorld).yzx * in_v.tangent.zzz) + u_xlat2.xyz);
          u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
          u_xlat0.x = rsqrt(u_xlat0.x);
          u_xlat2.xyz = (u_xlat0.xxx * u_xlat2.xyz);
          u_xlat3.xyz = (u_xlat1.xyz * u_xlat2.xyz);
          u_xlat3.xyz = ((u_xlat1.zxy * u_xlat2.yzx) + (-u_xlat3.xyz));
          u_xlat0.x = (in_v.tangent.w * unity_WorldTransformParams.w);
          u_xlat3.xyz = (u_xlat0.xxx * u_xlat3.xyz);
          out_v.texcoord1.y = u_xlat3.x;
          out_v.texcoord1.x = u_xlat2.z;
          out_v.texcoord1.z = u_xlat1.y;
          out_v.texcoord2.x = u_xlat2.x;
          out_v.texcoord3.x = u_xlat2.y;
          out_v.texcoord2.z = u_xlat1.z;
          out_v.texcoord3.z = u_xlat1.x;
          out_v.texcoord2.w = u_xlat0.y;
          out_v.texcoord3.w = u_xlat0.z;
          out_v.texcoord2.y = u_xlat3.y;
          out_v.texcoord3.y = u_xlat3.z;
          out_v.texcoord6 = float4(0, 0, 0, 0);
          out_v.texcoord7 = float4(0, 0, 0, 0);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float3 u_xlat1_d;
      float4 u_xlat16_1;
      int u_xlatb1;
      float3 u_xlat16_2;
      float3 u_xlat16_3;
      float3 u_xlat16_4;
      float3 u_xlatb4;
      float3 u_xlat16_5;
      float3 u_xlat16_6;
      float u_xlat8;
      int u_xlatb8;
      float u_xlat16_10;
      int u_xlatb15;
      float u_xlat21;
      float u_xlat16_23;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.x = in_f.texcoord1.w;
          u_xlat0_d.y = in_f.texcoord2.w;
          u_xlat0_d.z = in_f.texcoord3.w;
          u_xlat0_d.xyz = ((-u_xlat0_d.xyz) + _WorldSpaceCameraPos.xyz);
          u_xlat21 = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          u_xlat21 = rsqrt(u_xlat21);
          u_xlat16_1 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_2.xyz = (u_xlat16_1.xyz * _Color.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb1 = (0<_Amount);
          #else
          u_xlatb1 = (0<_Amount);
          #endif
          if(u_xlatb1)
          {
              u_xlat1_d.xy = (in_f.texcoord.xy / float2(float2(_Tile, _Tile)));
              u_xlat16_1.x = tex2D(_MainTex, u_xlat1_d.xy).x;
              u_xlat1_d.x = (u_xlat16_1.x + (-_Amount));
              #ifdef UNITY_ADRENO_ES3
              u_xlatb8 = (u_xlat1_d.x<0);
              #else
              u_xlatb8 = (u_xlat1_d.x<0);
              #endif
              if(u_xlatb8)
              {
                  u_xlat16_3.x = float(0);
                  u_xlat16_3.y = float(0);
                  u_xlat16_3.z = float(1);
                  u_xlat8 = 1;
              }
              else
              {
                  #ifdef UNITY_ADRENO_ES3
                  u_xlatb15 = (u_xlat1_d.x<_StartAmount);
                  #else
                  u_xlatb15 = (u_xlat1_d.x<_StartAmount);
                  #endif
                  if(u_xlatb15)
                  {
                      u_xlatb4.xyz = bool4(_ColorAnimate.xyzx == float4(0, 0, 0, 0)).xyz;
                      u_xlat1_d.x = (u_xlat1_d.x / _StartAmount);
                      u_xlat16_5.x = (u_xlatb4.x)?(_DissColor.x):(u_xlat1_d.x);
                      u_xlat16_5.y = (u_xlatb4.y)?(_DissColor.y):(u_xlat1_d.x);
                      u_xlat16_5.z = (u_xlatb4.z)?(_DissColor.z):(u_xlat1_d.x);
                      u_xlat16_23 = (u_xlat16_5.y + u_xlat16_5.x);
                      u_xlat16_23 = (u_xlat16_5.z + u_xlat16_23);
                      u_xlat16_6.xyz = (float3(u_xlat16_23, u_xlat16_23, u_xlat16_23) * u_xlat16_2.xyz);
                      u_xlat16_5.xyz = (u_xlat16_5.xyz * u_xlat16_6.xyz);
                      u_xlat16_5.xyz = (float3(u_xlat16_23, u_xlat16_23, u_xlat16_23) * u_xlat16_5.xyz);
                      u_xlat16_23 = ((-_Illuminate) + 1);
                      u_xlat16_2.xyz = (u_xlat16_5.xyz / float3(u_xlat16_23, u_xlat16_23, u_xlat16_23));
                      u_xlat16_4.xyz = tex2D(_DissolveSrcBump, in_f.texcoord.zw).xyz;
                      u_xlat16_3.xyz = ((u_xlat16_4.xyz * float3(2, 2, 2)) + float3(-1, (-1), (-1)));
                  }
                  else
                  {
                      u_xlat16_3.x = float(0);
                      u_xlat16_3.y = float(0);
                      u_xlat16_3.z = float(1);
                  }
                  u_xlat8 = 0;
              }
          }
          else
          {
              u_xlat16_3.x = float(0);
              u_xlat16_3.y = float(0);
              u_xlat16_3.z = float(1);
              u_xlat8 = 0;
          }
          #ifdef UNITY_ADRENO_ES3
          u_xlatb1 = (u_xlat8==1);
          #else
          u_xlatb1 = (u_xlat8==1);
          #endif
          if(((int(u_xlatb1) * int(4294967295))!=0))
          {
              discard;
          }
          u_xlat16_5.x = dot(in_f.texcoord1.xyz, u_xlat16_3.xyz);
          u_xlat16_5.y = dot(in_f.texcoord2.xyz, u_xlat16_3.xyz);
          u_xlat16_5.z = dot(in_f.texcoord3.xyz, u_xlat16_3.xyz);
          u_xlat1_d.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
          u_xlat1_d.x = rsqrt(u_xlat1_d.x);
          u_xlat1_d.xyz = (u_xlat1_d.xxx * u_xlat16_5.xyz);
          u_xlat16_3.xyz = ((u_xlat0_d.xyz * float3(u_xlat21, u_xlat21, u_xlat21)) + _WorldSpaceLightPos0.xyz);
          u_xlat16_3.xyz = normalize(u_xlat16_3.xyz);
          u_xlat16_23 = dot(u_xlat1_d.xyz, _WorldSpaceLightPos0.xyz);
          u_xlat16_23 = max(u_xlat16_23, 0);
          u_xlat16_3.x = dot(u_xlat1_d.xyz, u_xlat16_3.xyz);
          u_xlat16_3.x = max(u_xlat16_3.x, 0);
          u_xlat16_10 = (_Shininess * 128);
          u_xlat0_d.x = log2(u_xlat16_3.x);
          u_xlat0_d.x = (u_xlat0_d.x * u_xlat16_10);
          u_xlat0_d.x = exp2(u_xlat0_d.x);
          u_xlat0_d.x = (u_xlat16_1.w * u_xlat0_d.x);
          u_xlat16_2.xyz = (u_xlat16_2.xyz * _LightColor0.xyz);
          u_xlat16_3.xyz = (_LightColor0.xyz * _SpecColor.xyz);
          u_xlat0_d.xyz = (u_xlat0_d.xxx * u_xlat16_3.xyz);
          u_xlat0_d.xyz = ((u_xlat16_2.xyz * float3(u_xlat16_23, u_xlat16_23, u_xlat16_23)) + u_xlat0_d.xyz);
          out_f.color.xyz = u_xlat0_d.xyz;
          out_f.color.w = 1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "LIGHTMODE" = "FORWARDADD"
        "RenderType" = "Opaque"
      }
      LOD 400
      ZWrite Off
      Cull Off
      Blend One One
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile POINT
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
      //uniform float4x4 unity_WorldToObject;
      //uniform float4 unity_WorldTransformParams;
      //uniform float4x4 unity_MatrixVP;
      uniform float4x4 unity_WorldToLight;
      uniform float4 _MainTex_ST;
      uniform float4 DissolveSrc_ST;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _WorldSpaceLightPos0;
      uniform float4 _LightColor0;
      uniform float4 _SpecColor;
      uniform float4 _Color;
      uniform float4 _DissColor;
      uniform float _Shininess;
      uniform float _Amount;
      uniform float4 _ColorAnimate;
      uniform float _Illuminate;
      uniform float _Tile;
      uniform float _StartAmount;
      uniform sampler2D _MainTex;
      uniform sampler2D _DissolveSrcBump;
      uniform sampler2D _LightTexture0;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 tangent :TANGENT0;
          float3 normal :NORMAL0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
          float3 texcoord5 :TEXCOORD5;
          float4 texcoord6 :TEXCOORD6;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float3 u_xlat3;
      float u_xlat13;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.texcoord.zw = TRANSFORM_TEX(in_v.texcoord.xy, DissolveSrc);
          u_xlat1.y = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat1.z = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat1.x = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat1.xyz = normalize(u_xlat1.xyz);
          u_xlat2.xyz = (in_v.tangent.yyy * conv_mxt4x4_1(unity_ObjectToWorld).yzx);
          u_xlat2.xyz = ((conv_mxt4x4_0(unity_ObjectToWorld).yzx * in_v.tangent.xxx) + u_xlat2.xyz);
          u_xlat2.xyz = ((conv_mxt4x4_2(unity_ObjectToWorld).yzx * in_v.tangent.zzz) + u_xlat2.xyz);
          u_xlat2.xyz = normalize(u_xlat2.xyz);
          u_xlat3.xyz = (u_xlat1.xyz * u_xlat2.xyz);
          u_xlat3.xyz = ((u_xlat1.zxy * u_xlat2.yzx) + (-u_xlat3.xyz));
          u_xlat13 = (in_v.tangent.w * unity_WorldTransformParams.w);
          u_xlat3.xyz = (float3(u_xlat13, u_xlat13, u_xlat13) * u_xlat3.xyz);
          out_v.texcoord1.y = u_xlat3.x;
          out_v.texcoord1.x = u_xlat2.z;
          out_v.texcoord1.z = u_xlat1.y;
          out_v.texcoord2.x = u_xlat2.x;
          out_v.texcoord3.x = u_xlat2.y;
          out_v.texcoord2.z = u_xlat1.z;
          out_v.texcoord3.z = u_xlat1.x;
          out_v.texcoord2.y = u_xlat3.y;
          out_v.texcoord3.y = u_xlat3.z;
          out_v.texcoord4.xyz = ((conv_mxt4x4_3(unity_ObjectToWorld).xyz * in_v.vertex.www) + u_xlat0.xyz);
          u_xlat0 = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat0);
          u_xlat1.xyz = (u_xlat0.yyy * conv_mxt4x4_1(unity_WorldToLight).xyz);
          u_xlat1.xyz = ((conv_mxt4x4_0(unity_WorldToLight).xyz * u_xlat0.xxx) + u_xlat1.xyz);
          u_xlat0.xyz = ((conv_mxt4x4_2(unity_WorldToLight).xyz * u_xlat0.zzz) + u_xlat1.xyz);
          out_v.texcoord5.xyz = ((conv_mxt4x4_3(unity_WorldToLight).xyz * u_xlat0.www) + u_xlat0.xyz);
          out_v.texcoord6 = float4(0, 0, 0, 0);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float3 u_xlat1_d;
      float3 u_xlat2_d;
      float4 u_xlat16_2;
      int u_xlatb2;
      float3 u_xlat16_3;
      float3 u_xlat16_4;
      float3 u_xlat16_5;
      float3 u_xlatb5;
      float3 u_xlat16_6;
      float3 u_xlat16_7;
      int u_xlatb10;
      float u_xlat24;
      float u_xlat25;
      float u_xlat16_25;
      int u_xlatb25;
      float u_xlat16_27;
      float u_xlat16_28;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xyz = ((-in_f.texcoord4.xyz) + _WorldSpaceLightPos0.xyz);
          u_xlat0_d.xyz = normalize(u_xlat0_d.xyz);
          u_xlat1_d.xyz = ((-in_f.texcoord4.xyz) + _WorldSpaceCameraPos.xyz);
          u_xlat24 = dot(u_xlat1_d.xyz, u_xlat1_d.xyz);
          u_xlat24 = rsqrt(u_xlat24);
          u_xlat16_2 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_3.xyz = (u_xlat16_2.xyz * _Color.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb25 = (0<_Amount);
          #else
          u_xlatb25 = (0<_Amount);
          #endif
          if(u_xlatb25)
          {
              u_xlat2_d.xy = (in_f.texcoord.xy / float2(float2(_Tile, _Tile)));
              u_xlat16_25 = tex2D(_MainTex, u_xlat2_d.xy).x;
              u_xlat25 = (u_xlat16_25 + (-_Amount));
              #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = (u_xlat25<0);
              #else
              u_xlatb2 = (u_xlat25<0);
              #endif
              if(u_xlatb2)
              {
                  u_xlat16_4.x = float(0);
                  u_xlat16_4.y = float(0);
                  u_xlat16_4.z = float(1);
                  u_xlat2_d.x = 1;
              }
              else
              {
                  #ifdef UNITY_ADRENO_ES3
                  u_xlatb10 = (u_xlat25<_StartAmount);
                  #else
                  u_xlatb10 = (u_xlat25<_StartAmount);
                  #endif
                  if(u_xlatb10)
                  {
                      u_xlatb5.xyz = bool4(_ColorAnimate.xyzx == float4(0, 0, 0, 0)).xyz;
                      u_xlat25 = (u_xlat25 / _StartAmount);
                      u_xlat16_6.x = (u_xlatb5.x)?(_DissColor.x):(float(u_xlat25));
                      u_xlat16_6.y = (u_xlatb5.y)?(_DissColor.y):(float(u_xlat25));
                      u_xlat16_6.z = (u_xlatb5.z)?(_DissColor.z):(float(u_xlat25));
                      u_xlat16_27 = (u_xlat16_6.y + u_xlat16_6.x);
                      u_xlat16_27 = (u_xlat16_6.z + u_xlat16_27);
                      u_xlat16_7.xyz = (float3(u_xlat16_27, u_xlat16_27, u_xlat16_27) * u_xlat16_3.xyz);
                      u_xlat16_6.xyz = (u_xlat16_6.xyz * u_xlat16_7.xyz);
                      u_xlat16_6.xyz = (float3(u_xlat16_27, u_xlat16_27, u_xlat16_27) * u_xlat16_6.xyz);
                      u_xlat16_27 = ((-_Illuminate) + 1);
                      u_xlat16_3.xyz = (u_xlat16_6.xyz / float3(u_xlat16_27, u_xlat16_27, u_xlat16_27));
                      u_xlat16_5.xyz = tex2D(_DissolveSrcBump, in_f.texcoord.zw).xyz;
                      u_xlat16_4.xyz = ((u_xlat16_5.xyz * float3(2, 2, 2)) + float3(-1, (-1), (-1)));
                  }
                  else
                  {
                      u_xlat16_4.x = float(0);
                      u_xlat16_4.y = float(0);
                      u_xlat16_4.z = float(1);
                  }
                  u_xlat2_d.x = 0;
              }
          }
          else
          {
              u_xlat16_4.x = float(0);
              u_xlat16_4.y = float(0);
              u_xlat16_4.z = float(1);
              u_xlat2_d.x = 0;
          }
          #ifdef UNITY_ADRENO_ES3
          u_xlatb25 = (u_xlat2_d.x==1);
          #else
          u_xlatb25 = (u_xlat2_d.x==1);
          #endif
          if(((int(u_xlatb25) * int(4294967295))!=0))
          {
              discard;
          }
          u_xlat2_d.xyz = (in_f.texcoord4.yyy * conv_mxt4x4_1(unity_WorldToLight).xyz);
          u_xlat2_d.xyz = ((conv_mxt4x4_0(unity_WorldToLight).xyz * in_f.texcoord4.xxx) + u_xlat2_d.xyz);
          u_xlat2_d.xyz = ((conv_mxt4x4_2(unity_WorldToLight).xyz * in_f.texcoord4.zzz) + u_xlat2_d.xyz);
          u_xlat2_d.xyz = (u_xlat2_d.xyz + conv_mxt4x4_3(unity_WorldToLight).xyz);
          u_xlat25 = dot(u_xlat2_d.xyz, u_xlat2_d.xyz);
          u_xlat25 = tex2D(_LightTexture0, float2(u_xlat25, u_xlat25)).x;
          u_xlat16_6.x = dot(in_f.texcoord1.xyz, u_xlat16_4.xyz);
          u_xlat16_6.y = dot(in_f.texcoord2.xyz, u_xlat16_4.xyz);
          u_xlat16_6.z = dot(in_f.texcoord3.xyz, u_xlat16_4.xyz);
          u_xlat2_d.x = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
          u_xlat2_d.x = rsqrt(u_xlat2_d.x);
          u_xlat2_d.xyz = (u_xlat2_d.xxx * u_xlat16_6.xyz);
          u_xlat16_4.xyz = (float3(u_xlat25, u_xlat25, u_xlat25) * _LightColor0.xyz);
          u_xlat16_6.xyz = ((u_xlat1_d.xyz * float3(u_xlat24, u_xlat24, u_xlat24)) + u_xlat0_d.xyz);
          u_xlat16_6.xyz = normalize(u_xlat16_6.xyz);
          u_xlat16_27 = dot(u_xlat2_d.xyz, u_xlat0_d.xyz);
          u_xlat16_27 = max(u_xlat16_27, 0);
          u_xlat16_28 = dot(u_xlat2_d.xyz, u_xlat16_6.xyz);
          u_xlat16_28 = max(u_xlat16_28, 0);
          u_xlat16_6.x = (_Shininess * 128);
          u_xlat0_d.x = log2(u_xlat16_28);
          u_xlat0_d.x = (u_xlat0_d.x * u_xlat16_6.x);
          u_xlat0_d.x = exp2(u_xlat0_d.x);
          u_xlat0_d.x = (u_xlat16_2.w * u_xlat0_d.x);
          u_xlat16_3.xyz = (u_xlat16_3.xyz * u_xlat16_4.xyz);
          u_xlat16_4.xyz = (u_xlat16_4.xyz * _SpecColor.xyz);
          u_xlat0_d.xyz = (u_xlat0_d.xxx * u_xlat16_4.xyz);
          u_xlat0_d.xyz = ((u_xlat16_3.xyz * float3(u_xlat16_27, u_xlat16_27, u_xlat16_27)) + u_xlat0_d.xyz);
          out_f.color.xyz = u_xlat0_d.xyz;
          out_f.color.w = 1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: PREPASS
    {
      Name "PREPASS"
      Tags
      { 
        "LIGHTMODE" = "PREPASSBASE"
        "RenderType" = "Opaque"
      }
      LOD 400
      Cull Off
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
      //uniform float4x4 unity_WorldToObject;
      //uniform float4 unity_WorldTransformParams;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4 DissolveSrc_ST;
      uniform float _Shininess;
      uniform float _Amount;
      uniform float _Tile;
      uniform float _StartAmount;
      uniform sampler2D _MainTex;
      uniform sampler2D _DissolveSrcBump;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 tangent :TANGENT0;
          float3 normal :NORMAL0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
          float4 texcoord3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
          float4 texcoord3 :TEXCOORD3;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float3 u_xlat3;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          u_xlat0.xyz = ((conv_mxt4x4_3(unity_ObjectToWorld).xyz * in_v.vertex.www) + u_xlat0.xyz);
          out_v.vertex = mul(unity_MatrixVP, u_xlat1);
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.texcoord.zw = TRANSFORM_TEX(in_v.texcoord.xy, DissolveSrc);
          out_v.texcoord1.w = u_xlat0.x;
          u_xlat1.y = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat1.z = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat1.x = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
          u_xlat0.x = rsqrt(u_xlat0.x);
          u_xlat1.xyz = (u_xlat0.xxx * u_xlat1.xyz);
          u_xlat2.xyz = (in_v.tangent.yyy * conv_mxt4x4_1(unity_ObjectToWorld).yzx);
          u_xlat2.xyz = ((conv_mxt4x4_0(unity_ObjectToWorld).yzx * in_v.tangent.xxx) + u_xlat2.xyz);
          u_xlat2.xyz = ((conv_mxt4x4_2(unity_ObjectToWorld).yzx * in_v.tangent.zzz) + u_xlat2.xyz);
          u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
          u_xlat0.x = rsqrt(u_xlat0.x);
          u_xlat2.xyz = (u_xlat0.xxx * u_xlat2.xyz);
          u_xlat3.xyz = (u_xlat1.xyz * u_xlat2.xyz);
          u_xlat3.xyz = ((u_xlat1.zxy * u_xlat2.yzx) + (-u_xlat3.xyz));
          u_xlat0.x = (in_v.tangent.w * unity_WorldTransformParams.w);
          u_xlat3.xyz = (u_xlat0.xxx * u_xlat3.xyz);
          out_v.texcoord1.y = u_xlat3.x;
          out_v.texcoord1.x = u_xlat2.z;
          out_v.texcoord1.z = u_xlat1.y;
          out_v.texcoord2.x = u_xlat2.x;
          out_v.texcoord3.x = u_xlat2.y;
          out_v.texcoord2.z = u_xlat1.z;
          out_v.texcoord3.z = u_xlat1.x;
          out_v.texcoord2.w = u_xlat0.y;
          out_v.texcoord3.w = u_xlat0.z;
          out_v.texcoord2.y = u_xlat3.y;
          out_v.texcoord3.y = u_xlat3.z;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float4 u_xlat16_0;
      int u_xlatb0;
      float3 u_xlat16_1;
      float3 u_xlat16_2;
      float u_xlat3_d;
      int u_xlatb3;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0 = (0<_Amount);
          #else
          u_xlatb0 = (0<_Amount);
          #endif
          if(u_xlatb0)
          {
              u_xlat0_d.xy = (in_f.texcoord.xy / float2(float2(_Tile, _Tile)));
              u_xlat16_0.x = tex2D(_MainTex, u_xlat0_d.xy).x;
              u_xlat0_d.x = (u_xlat16_0.x + (-_Amount));
              #ifdef UNITY_ADRENO_ES3
              u_xlatb3 = (u_xlat0_d.x<0);
              #else
              u_xlatb3 = (u_xlat0_d.x<0);
              #endif
              if(u_xlatb3)
              {
                  u_xlat16_1.x = float(0);
                  u_xlat16_1.y = float(0);
                  u_xlat16_1.z = float(1);
                  u_xlat3_d = 1;
              }
              else
              {
                  #ifdef UNITY_ADRENO_ES3
                  u_xlatb0 = (u_xlat0_d.x<_StartAmount);
                  #else
                  u_xlatb0 = (u_xlat0_d.x<_StartAmount);
                  #endif
                  if(u_xlatb0)
                  {
                      u_xlat16_0.xzw = tex2D(_DissolveSrcBump, in_f.texcoord.zw).xyz;
                      u_xlat16_1.xyz = ((u_xlat16_0.xzw * float3(2, 2, 2)) + float3(-1, (-1), (-1)));
                  }
                  else
                  {
                      u_xlat16_1.x = float(0);
                      u_xlat16_1.y = float(0);
                      u_xlat16_1.z = float(1);
                  }
                  u_xlat3_d = 0;
              }
          }
          else
          {
              u_xlat16_1.x = float(0);
              u_xlat16_1.y = float(0);
              u_xlat16_1.z = float(1);
              u_xlat3_d = 0;
          }
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0 = (u_xlat3_d==1);
          #else
          u_xlatb0 = (u_xlat3_d==1);
          #endif
          if(((int(u_xlatb0) * int(4294967295))!=0))
          {
              discard;
          }
          u_xlat16_2.x = dot(in_f.texcoord1.xyz, u_xlat16_1.xyz);
          u_xlat16_2.y = dot(in_f.texcoord2.xyz, u_xlat16_1.xyz);
          u_xlat16_2.z = dot(in_f.texcoord3.xyz, u_xlat16_1.xyz);
          u_xlat0_d.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
          u_xlat0_d.x = rsqrt(u_xlat0_d.x);
          u_xlat0_d.xyz = (u_xlat0_d.xxx * u_xlat16_2.xyz);
          out_f.color.xyz = ((u_xlat0_d.xyz * float3(0.5, 0.5, 0.5)) + float3(0.5, 0.5, 0.5));
          out_f.color.w = _Shininess;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 4, name: PREPASS
    {
      Name "PREPASS"
      Tags
      { 
        "LIGHTMODE" = "PREPASSFINAL"
        "RenderType" = "Opaque"
      }
      LOD 400
      ZWrite Off
      Cull Off
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
      //uniform float4 unity_SHAr;
      //uniform float4 unity_SHAg;
      //uniform float4 unity_SHAb;
      //uniform float4 unity_SHBr;
      //uniform float4 unity_SHBg;
      //uniform float4 unity_SHBb;
      //uniform float4 unity_SHC;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4 _SpecColor;
      uniform float4 _Color;
      uniform float4 _DissColor;
      uniform float _Amount;
      uniform float4 _ColorAnimate;
      uniform float _Illuminate;
      uniform float _Tile;
      uniform float _StartAmount;
      uniform sampler2D _MainTex;
      uniform sampler2D _LightBuffer;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
          float4 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord2 :TEXCOORD2;
          float3 texcoord4 :TEXCOORD4;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat16_1;
      float3 u_xlat16_2;
      float3 u_xlat16_3;
      float u_xlat12;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          out_v.texcoord1.xyz = ((conv_mxt4x4_3(unity_ObjectToWorld).xyz * in_v.vertex.www) + u_xlat0.xyz);
          u_xlat0 = mul(unity_MatrixVP, u_xlat1);
          out_v.vertex = u_xlat0;
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          u_xlat0.y = (u_xlat0.y * _ProjectionParams.x);
          u_xlat1.xzw = (u_xlat0.xwy * float3(0.5, 0.5, 0.5));
          out_v.texcoord2.zw = u_xlat0.zw;
          out_v.texcoord2.xy = (u_xlat1.zz + u_xlat1.xw);
          out_v.texcoord3 = float4(0, 0, 0, 0);
          u_xlat0.x = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat0.y = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat0.z = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat0.xyz = normalize(u_xlat0.xyz);
          u_xlat16_2.x = (u_xlat0.y * u_xlat0.y);
          u_xlat16_2.x = ((u_xlat0.x * u_xlat0.x) + (-u_xlat16_2.x));
          u_xlat16_1 = (u_xlat0.yzzx * u_xlat0.xyzz);
          u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
          u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
          u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
          u_xlat16_2.xyz = ((unity_SHC.xyz * u_xlat16_2.xxx) + u_xlat16_3.xyz);
          u_xlat0.w = 1;
          u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
          u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
          u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
          u_xlat16_2.xyz = (u_xlat16_2.xyz + u_xlat16_3.xyz);
          out_v.texcoord4.xyz = u_xlat16_2.xyz;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float4 u_xlat16_0;
      int u_xlatb0;
      float3 u_xlat16_1_d;
      float4 u_xlat16_2_d;
      float3 u_xlatb2;
      float3 u_xlat16_3_d;
      float3 u_xlat16_4;
      float u_xlat5;
      int u_xlatb5;
      int u_xlatb10;
      float u_xlat16_16;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_1_d.xyz = (u_xlat16_0.xyz * _Color.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0 = (0<_Amount);
          #else
          u_xlatb0 = (0<_Amount);
          #endif
          if(u_xlatb0)
          {
              u_xlat0_d.xy = (in_f.texcoord.xy / float2(float2(_Tile, _Tile)));
              u_xlat16_0.x = tex2D(_MainTex, u_xlat0_d.xy).x;
              u_xlat0_d.x = (u_xlat16_0.x + (-_Amount));
              #ifdef UNITY_ADRENO_ES3
              u_xlatb5 = (u_xlat0_d.x<0);
              #else
              u_xlatb5 = (u_xlat0_d.x<0);
              #endif
              if(u_xlatb5)
              {
                  u_xlat5 = 1;
              }
              else
              {
                  #ifdef UNITY_ADRENO_ES3
                  u_xlatb10 = (u_xlat0_d.x<_StartAmount);
                  #else
                  u_xlatb10 = (u_xlat0_d.x<_StartAmount);
                  #endif
                  if(u_xlatb10)
                  {
                      u_xlatb2.xyz = bool4(_ColorAnimate.xyzx == float4(0, 0, 0, 0)).xyz;
                      u_xlat0_d.x = (u_xlat0_d.x / _StartAmount);
                      u_xlat16_3_d.x = (u_xlatb2.x)?(_DissColor.x):(u_xlat0_d.x);
                      u_xlat16_3_d.y = (u_xlatb2.y)?(_DissColor.y):(u_xlat0_d.x);
                      u_xlat16_3_d.z = (u_xlatb2.z)?(_DissColor.z):(u_xlat0_d.x);
                      u_xlat16_16 = (u_xlat16_3_d.y + u_xlat16_3_d.x);
                      u_xlat16_16 = (u_xlat16_3_d.z + u_xlat16_16);
                      u_xlat16_4.xyz = (float3(u_xlat16_16, u_xlat16_16, u_xlat16_16) * u_xlat16_1_d.xyz);
                      u_xlat16_3_d.xyz = (u_xlat16_3_d.xyz * u_xlat16_4.xyz);
                      u_xlat16_3_d.xyz = (float3(u_xlat16_16, u_xlat16_16, u_xlat16_16) * u_xlat16_3_d.xyz);
                      u_xlat16_16 = ((-_Illuminate) + 1);
                      u_xlat16_1_d.xyz = (u_xlat16_3_d.xyz / float3(u_xlat16_16, u_xlat16_16, u_xlat16_16));
                  }
                  u_xlat5 = 0;
              }
          }
          else
          {
              u_xlat5 = 0;
          }
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0 = (u_xlat5==1);
          #else
          u_xlatb0 = (u_xlat5==1);
          #endif
          if(((int(u_xlatb0) * int(4294967295))!=0))
          {
              discard;
          }
          u_xlat0_d.xy = (in_f.texcoord2.xy / in_f.texcoord2.ww);
          u_xlat16_2_d = tex2D(_LightBuffer, u_xlat0_d.xy);
          u_xlat16_2_d = max(u_xlat16_2_d, float4(0.00100000005, 0.00100000005, 0.00100000005, 0.00100000005));
          u_xlat16_2_d = log2(u_xlat16_2_d);
          u_xlat0_d.xyz = ((-u_xlat16_2_d.xyz) + in_f.texcoord4.xyz);
          u_xlat16_16 = (u_xlat16_0.w * (-u_xlat16_2_d.w));
          u_xlat16_3_d.xyz = (u_xlat0_d.xyz * _SpecColor.xyz);
          u_xlat16_3_d.xyz = (float3(u_xlat16_16, u_xlat16_16, u_xlat16_16) * u_xlat16_3_d.xyz);
          out_f.color.xyz = ((u_xlat16_1_d.xyz * u_xlat0_d.xyz) + u_xlat16_3_d.xyz);
          out_f.color.w = 1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 5, name: DEFERRED
    {
      Name "DEFERRED"
      Tags
      { 
        "LIGHTMODE" = "DEFERRED"
        "RenderType" = "Opaque"
      }
      LOD 400
      Cull Off
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
      //uniform float4x4 unity_WorldToObject;
      //uniform float4 unity_WorldTransformParams;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4 DissolveSrc_ST;
      uniform float4 _SpecColor;
      uniform float4 _Color;
      uniform float4 _DissColor;
      uniform float _Shininess;
      uniform float _Amount;
      uniform float4 _ColorAnimate;
      uniform float _Illuminate;
      uniform float _Tile;
      uniform float _StartAmount;
      uniform sampler2D _MainTex;
      uniform sampler2D _DissolveSrcBump;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 tangent :TANGENT0;
          float3 normal :NORMAL0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
          float4 texcoord3 :TEXCOORD3;
          float4 texcoord4 :TEXCOORD4;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
          float4 texcoord3 :TEXCOORD3;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
          float4 color1 :SV_Target1;
          float4 color2 :SV_Target2;
          float4 color3 :SV_Target3;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float3 u_xlat3;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          u_xlat0.xyz = ((conv_mxt4x4_3(unity_ObjectToWorld).xyz * in_v.vertex.www) + u_xlat0.xyz);
          out_v.vertex = mul(unity_MatrixVP, u_xlat1);
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.texcoord.zw = TRANSFORM_TEX(in_v.texcoord.xy, DissolveSrc);
          out_v.texcoord1.w = u_xlat0.x;
          u_xlat1.y = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat1.z = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat1.x = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
          u_xlat0.x = rsqrt(u_xlat0.x);
          u_xlat1.xyz = (u_xlat0.xxx * u_xlat1.xyz);
          u_xlat2.xyz = (in_v.tangent.yyy * conv_mxt4x4_1(unity_ObjectToWorld).yzx);
          u_xlat2.xyz = ((conv_mxt4x4_0(unity_ObjectToWorld).yzx * in_v.tangent.xxx) + u_xlat2.xyz);
          u_xlat2.xyz = ((conv_mxt4x4_2(unity_ObjectToWorld).yzx * in_v.tangent.zzz) + u_xlat2.xyz);
          u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
          u_xlat0.x = rsqrt(u_xlat0.x);
          u_xlat2.xyz = (u_xlat0.xxx * u_xlat2.xyz);
          u_xlat3.xyz = (u_xlat1.xyz * u_xlat2.xyz);
          u_xlat3.xyz = ((u_xlat1.zxy * u_xlat2.yzx) + (-u_xlat3.xyz));
          u_xlat0.x = (in_v.tangent.w * unity_WorldTransformParams.w);
          u_xlat3.xyz = (u_xlat0.xxx * u_xlat3.xyz);
          out_v.texcoord1.y = u_xlat3.x;
          out_v.texcoord1.x = u_xlat2.z;
          out_v.texcoord1.z = u_xlat1.y;
          out_v.texcoord2.x = u_xlat2.x;
          out_v.texcoord3.x = u_xlat2.y;
          out_v.texcoord2.z = u_xlat1.z;
          out_v.texcoord3.z = u_xlat1.x;
          out_v.texcoord2.w = u_xlat0.y;
          out_v.texcoord3.w = u_xlat0.z;
          out_v.texcoord2.y = u_xlat3.y;
          out_v.texcoord3.y = u_xlat3.z;
          out_v.texcoord4 = float4(0, 0, 0, 0);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float4 u_xlat16_0;
      int u_xlatb0;
      float3 u_xlat16_1;
      float3 u_xlat16_2;
      float3 u_xlat3_d;
      float3 u_xlat16_3;
      float3 u_xlatb3;
      float3 u_xlat16_4;
      float3 u_xlat16_5;
      float u_xlat6;
      int u_xlatb6;
      int u_xlatb12;
      float u_xlat16_19;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_1.xyz = (u_xlat16_0.xyz * _Color.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0 = (0<_Amount);
          #else
          u_xlatb0 = (0<_Amount);
          #endif
          if(u_xlatb0)
          {
              u_xlat0_d.xy = (in_f.texcoord.xy / float2(float2(_Tile, _Tile)));
              u_xlat16_0.x = tex2D(_MainTex, u_xlat0_d.xy).x;
              u_xlat0_d.x = (u_xlat16_0.x + (-_Amount));
              #ifdef UNITY_ADRENO_ES3
              u_xlatb6 = (u_xlat0_d.x<0);
              #else
              u_xlatb6 = (u_xlat0_d.x<0);
              #endif
              if(u_xlatb6)
              {
                  u_xlat16_2.x = float(0);
                  u_xlat16_2.y = float(0);
                  u_xlat16_2.z = float(1);
                  u_xlat6 = 1;
              }
              else
              {
                  #ifdef UNITY_ADRENO_ES3
                  u_xlatb12 = (u_xlat0_d.x<_StartAmount);
                  #else
                  u_xlatb12 = (u_xlat0_d.x<_StartAmount);
                  #endif
                  if(u_xlatb12)
                  {
                      u_xlatb3.xyz = bool4(_ColorAnimate.xyzx == float4(0, 0, 0, 0)).xyz;
                      u_xlat0_d.x = (u_xlat0_d.x / _StartAmount);
                      u_xlat16_4.x = (u_xlatb3.x)?(_DissColor.x):(u_xlat0_d.x);
                      u_xlat16_4.y = (u_xlatb3.y)?(_DissColor.y):(u_xlat0_d.x);
                      u_xlat16_4.z = (u_xlatb3.z)?(_DissColor.z):(u_xlat0_d.x);
                      u_xlat16_19 = (u_xlat16_4.y + u_xlat16_4.x);
                      u_xlat16_19 = (u_xlat16_4.z + u_xlat16_19);
                      u_xlat16_5.xyz = (float3(u_xlat16_19, u_xlat16_19, u_xlat16_19) * u_xlat16_1.xyz);
                      u_xlat16_4.xyz = (u_xlat16_4.xyz * u_xlat16_5.xyz);
                      u_xlat16_4.xyz = (float3(u_xlat16_19, u_xlat16_19, u_xlat16_19) * u_xlat16_4.xyz);
                      u_xlat16_19 = ((-_Illuminate) + 1);
                      u_xlat16_1.xyz = (u_xlat16_4.xyz / float3(u_xlat16_19, u_xlat16_19, u_xlat16_19));
                      u_xlat16_3.xyz = tex2D(_DissolveSrcBump, in_f.texcoord.zw).xyz;
                      u_xlat16_2.xyz = ((u_xlat16_3.xyz * float3(2, 2, 2)) + float3(-1, (-1), (-1)));
                  }
                  else
                  {
                      u_xlat16_2.x = float(0);
                      u_xlat16_2.y = float(0);
                      u_xlat16_2.z = float(1);
                  }
                  u_xlat6 = 0;
              }
          }
          else
          {
              u_xlat16_2.x = float(0);
              u_xlat16_2.y = float(0);
              u_xlat16_2.z = float(1);
              u_xlat6 = 0;
          }
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0 = (u_xlat6==1);
          #else
          u_xlatb0 = (u_xlat6==1);
          #endif
          if(((int(u_xlatb0) * int(4294967295))!=0))
          {
              discard;
          }
          u_xlat16_4.x = dot(in_f.texcoord1.xyz, u_xlat16_2.xyz);
          u_xlat16_4.y = dot(in_f.texcoord2.xyz, u_xlat16_2.xyz);
          u_xlat16_4.z = dot(in_f.texcoord3.xyz, u_xlat16_2.xyz);
          u_xlat0_d.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
          u_xlat0_d.x = rsqrt(u_xlat0_d.x);
          u_xlat0_d.xyz = (u_xlat0_d.xxx * u_xlat16_4.xyz);
          u_xlat16_2.xyz = (u_xlat16_0.www * _SpecColor.xyz);
          u_xlat3_d.xyz = (u_xlat16_2.xyz * float3(0.318309873, 0.318309873, 0.318309873));
          u_xlat0_d.xyz = ((u_xlat0_d.xyz * float3(0.5, 0.5, 0.5)) + float3(0.5, 0.5, 0.5));
          out_f.color.xyz = u_xlat16_1.xyz;
          out_f.color.w = 1;
          out_f.color1.xyz = u_xlat3_d.xyz;
          out_f.color1.w = _Shininess;
          out_f.color2.xyz = u_xlat0_d.xyz;
          out_f.color2.w = 1;
          out_f.color3 = float4(1, 1, 1, 1);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 6, name: ShadowCaster
    {
      Name "ShadowCaster"
      Tags
      { 
        "LIGHTMODE" = "SHADOWCASTER"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      LOD 400
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile SHADOWS_DEPTH
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _WorldSpaceLightPos0;
      //uniform float4 unity_LightShadowBias;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float _Amount;
      uniform float _Tile;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float u_xlat6;
      float u_xlat9;
      int u_xlatb9;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.x = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat0.y = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat0.z = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat0.xyz = normalize(u_xlat0.xyz);
          u_xlat1 = mul(unity_ObjectToWorld, in_v.vertex);
          u_xlat2.xyz = (((-u_xlat1.xyz) * _WorldSpaceLightPos0.www) + _WorldSpaceLightPos0.xyz);
          u_xlat2.xyz = normalize(u_xlat2.xyz);
          u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
          u_xlat9 = (((-u_xlat9) * u_xlat9) + 1);
          u_xlat9 = sqrt(u_xlat9);
          u_xlat9 = (u_xlat9 * unity_LightShadowBias.z);
          u_xlat0.xyz = (((-u_xlat0.xyz) * float3(u_xlat9, u_xlat9, u_xlat9)) + u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb9 = (unity_LightShadowBias.z!=0);
          #else
          u_xlatb9 = (unity_LightShadowBias.z!=0);
          #endif
          u_xlat0.xyz = (int(u_xlatb9))?(u_xlat0.xyz):(u_xlat1.xyz);
          u_xlat0 = mul(unity_MatrixVP, u_xlat0);
          u_xlat1.x = (unity_LightShadowBias.x / u_xlat0.w);
          #ifdef UNITY_ADRENO_ES3
          u_xlat1.x = min(max(u_xlat1.x, 0), 1);
          #else
          u_xlat1.x = clamp(u_xlat1.x, 0, 1);
          #endif
          u_xlat6 = (u_xlat0.z + u_xlat1.x);
          u_xlat1.x = max((-u_xlat0.w), u_xlat6);
          out_v.vertex.xyw = u_xlat0.xyw;
          u_xlat0.x = ((-u_xlat6) + u_xlat1.x);
          out_v.vertex.z = ((unity_LightShadowBias.y * u_xlat0.x) + u_xlat6);
          out_v.texcoord1.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          u_xlat0.xyz = (in_v.vertex.yyy * conv_mxt4x4_1(unity_ObjectToWorld).xyz);
          u_xlat0.xyz = ((conv_mxt4x4_0(unity_ObjectToWorld).xyz * in_v.vertex.xxx) + u_xlat0.xyz);
          u_xlat0.xyz = ((conv_mxt4x4_2(unity_ObjectToWorld).xyz * in_v.vertex.zzz) + u_xlat0.xyz);
          out_v.texcoord2.xyz = ((conv_mxt4x4_3(unity_ObjectToWorld).xyz * in_v.vertex.www) + u_xlat0.xyz);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 u_xlat0_d;
      float u_xlat16_0;
      int u_xlatb0;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0 = (0<_Amount);
          #else
          u_xlatb0 = (0<_Amount);
          #endif
          if(u_xlatb0)
          {
              u_xlat0_d.xy = (in_f.texcoord1.xy / float2(float2(_Tile, _Tile)));
              u_xlat16_0 = tex2D(_MainTex, u_xlat0_d.xy).x;
              u_xlat0_d.x = (u_xlat16_0 + (-_Amount));
              #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = (u_xlat0_d.x<0);
              #else
              u_xlatb0 = (u_xlat0_d.x<0);
              #endif
              if(u_xlatb0)
              {
                  u_xlat0_d.x = 1;
              }
              else
              {
                  u_xlat0_d.x = 0;
              }
          }
          else
          {
              u_xlat0_d.x = 0;
          }
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0 = (u_xlat0_d.x==1);
          #else
          u_xlatb0 = (u_xlat0_d.x==1);
          #endif
          if(((int(u_xlatb0) * int(4294967295))!=0))
          {
              discard;
          }
          out_f.color = float4(0, 0, 0, 0);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Specular"
}
