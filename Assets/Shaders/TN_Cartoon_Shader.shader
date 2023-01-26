Shader "TN/Cartoon_Shader"
{
  Properties
  {
    _LdotN_Start ("LdotN_Start(陰影起點)", Range(0, 1)) = 0
    _LdotN_End ("LdotN_End(陰影終點)", Range(0, 1)) = 1
    _MainTex ("MainTex(主要貼圖)", 2D) = "black" {}
    _NormalMap ("NormalMpa(法線貼圖)", 2D) = "bump" {}
    _Normal_Intensity ("Normal_Intensity(法線強度)", Range(0, 10)) = 1
    [HDR] _MainColor ("MainTexColor(主貼圖顏色)", Color) = (1,1,1,1)
    [HDR] _ShadowColor ("ShadowColor(主陰影顏色)", Color) = (0.8,0.8,0.8,1)
    [HDR] _ShadowColor2 ("ShadowColor2(副陰影顏色)", Color) = (0.8,0.8,0.8,1)
    _ShadowMap ("ShadowMap(拆影遮罩R+手繪陰影G+高光遮罩B)", 2D) = "black" {}
    [MaterialToggle] _useShadowMap_R ("useShadowMap_R(分開兩種不同物件的陰影顏色)", float) = 0
    [MaterialToggle] _useShadowMap_G ("useShadowMap_G(陰影遮蔽區域//e.g 腋下、脖子、奶子下方)", float) = 0
    [MaterialToggle] _useShadowMap_B ("useShadowMap_B(頭髮高光區域)", float) = 0
    [HDR] _LightHair_Color ("LightHair_Color(頭髮高光顏色)", Color) = (1,1,1,1)
    _Metal_FLight_Emi_Map ("Metal_Specualr_Emission Map(金屬R+發光貼圖B)", 2D) = "white" {}
    [MaterialToggle] _useMetalMask ("useMetalMask(金屬物品遮罩)", float) = 0
    [MaterialToggle] _useFluidLightMask ("useFluidLightMask(流光遮罩)", float) = 0
    [MaterialToggle] _useEmissionlMask ("useEmissionMask(發光遮罩)", float) = 0
    _Specular_pow ("Specular(高光範圍)", Range(0.1, 1)) = 0.1
    _Metal_Intensity ("Metal_Intensity(金屬高光強度)", Range(0, 10)) = 1
    [HDR] _Emission_Color ("Emission_Color(發光顏色)", Color) = (1,1,1,1)
    _LightWrap_Start ("LightWrap_Start(環繞色起點)", Range(-1, 1)) = 0
    _LightWrap_End ("LightWrap_End(環繞色終點)", Range(-1, 1)) = 0
    _LightWrap1 ("LightWrap1(主環繞色)", Color) = (0,0,0,0)
    _LightWrap2 ("LightWrap2(副環繞色)", Color) = (0,0,0,0)
    _FresnelColor ("FresnelColor(背光顏色)", Color) = (0,0,0,0)
    _Fresnel_Start ("Fresnel_Start(背光範圍1)", Range(0, 1)) = 0
    _Fresnel_End ("Fresnel_End(背光範圍2)", Range(0, 1)) = 1
    [MaterialToggle] _useTangentNormal ("useTangentNormal(使用特殊法線製作描邊才打勾)", float) = 0
    [MaterialToggle] _Outline_ZWrite ("Outline_ZWrite(描邊遮醜)", float) = 1
    _OutLine_Width ("OutLineWidth(描邊粗細)", Range(0, 100)) = 0
    _OutLine_Color ("OutLineColor(主描邊顏色)", Color) = (0,0,0,0)
    _OutLine_Color2 ("OutLineColor2(副描邊顏色)", Color) = (0,0,0,0)
    _Alpha ("Alpha(透明度)", Range(0, 1)) = 1
    _Special_Mask ("SpecialMask(特殊遮罩// R:換膚色 G:霓光 B:臉紅 A:流光)", 2D) = "black" {}
    [HDR] _SkinColor2 ("SkinColor2(Alpha可控制)", Color) = (1,1,1,0)
    _NieoLight_Color ("NieoLight_Color(Alpha可控制)", Color) = (1,1,1,0)
    [MaterialToggle] _useZumiShy ("useZumiShy", float) = 0
    _ShyPos ("ShyPos", Range(0, 1)) = 0
    _ShySmooth ("ShySmooth", Range(-1, 1)) = 0
    [HDR] _ShyColor ("ShyColor", Color) = (1,1,1,0)
    _FluidLightVector ("FluidLightVector(x:流動速度 y:流光範圍 z:流光強度 w:啟用填1)", Vector) = (0,0,0,0)
    [HideInInspector] _Color ("Color", Color) = (1,1,1,1)
    [HideInInspector] _RimColor ("Rim Color", Color) = (0,0,0,1)
    [HideInInspector] _RimThreshold ("RimThreshold", Range(0, 1)) = 0
    _Ref ("Ref", float) = 0
    [Enum(UnityEngine.Rendering.CompareFunction)] _Comp ("Comparison", float) = 0
    [Enum(UnityEngine.Rendering.StencilOp)] _Pass ("Pass ", float) = 0
    [Enum(UnityEngine.Rendering.StencilOp)] _Fail ("Fail ", float) = 0
    [Enum(UnityEngine.Rendering.StencilOp)] _ZFail ("ZFail ", float) = 0
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: OutLine描邊
    {
      Name "OutLine描邊"
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
      }
      ZWrite Off
      Cull Front
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
      //uniform float4 _ScreenParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      uniform float _useTangentNormal;
      uniform float _OutLine_Width;
      uniform float _useTNCartoonOutline;
      uniform float4 _LightColor0;
      uniform float _useShadowMap_R;
      uniform float4 _OutLine_Color;
      uniform float4 _OutLine_Color2;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform sampler2D _ShadowMap;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 tangent :TANGENT0;
          float3 color :COLOR0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float3 vs_NORMAL0 :NORMAL0;
          float4 texcoord1 :TEXCOORD1;
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
      
      float3 u_xlat0;
      int u_xlatb0;
      float4 u_xlat1;
      float4 u_xlat2;
      float4 u_xlat3;
      float3 u_xlat4;
      int u_xlatb4;
      float u_xlat8;
      float u_xlat12;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0 = (_useTNCartoonOutline==1);
          #else
          u_xlatb0 = (_useTNCartoonOutline==1);
          #endif
          #ifdef UNITY_ADRENO_ES3
          u_xlatb4 = (_OutLine_Width==0);
          #else
          u_xlatb4 = (_OutLine_Width==0);
          #endif
          u_xlatb0 = (u_xlatb4 || u_xlatb0);
          if(u_xlatb0)
          {
              out_v.vertex = float4(0, 0, 0, 0);
              out_v.texcoord1 = float4(0, 0, 0, 0);
              out_v.vs_NORMAL0.xyz = float3(0, 0, 0);
              out_v.texcoord.xy = float2(0, 0);
              return out_v;
          }
          u_xlat0.x = ((-_useTangentNormal) + 1);
          u_xlat0.xyz = (u_xlat0.xxx * in_v.normal.xyz);
          u_xlat0.xyz = ((float3(float3(_useTangentNormal, _useTangentNormal, _useTangentNormal)) * in_v.tangent.xyz) + u_xlat0.xyz);
          u_xlat1.x = dot(u_xlat0.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat1.y = dot(u_xlat0.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat1.z = dot(u_xlat0.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
          u_xlat0.x = rsqrt(u_xlat0.x);
          u_xlat0.xyz = (u_xlat0.xxx * u_xlat1.xyz);
          u_xlat4.xz = (u_xlat0.yy * conv_mxt4x4_1(unity_MatrixVP).xy);
          u_xlat0.xy = ((conv_mxt4x4_0(unity_MatrixVP).xy * u_xlat0.xx) + u_xlat4.xz);
          u_xlat0.xy = ((conv_mxt4x4_2(unity_MatrixVP).xy * u_xlat0.zz) + u_xlat0.xy);
          u_xlat2 = mul(unity_ObjectToWorld, float4(in_v.vertex.xyz,1.0));
          u_xlat2 = mul(unity_MatrixVP, u_xlat2);
          u_xlat0.xy = normalize(u_xlat0.xy);
          u_xlat0.xy = (u_xlat0.xy / _ScreenParams.xy);
          u_xlat0.xy = (u_xlat0.xy * float2(float2(_OutLine_Width, _OutLine_Width)));
          u_xlat0.xy = (u_xlat2.ww * u_xlat0.xy);
          out_v.vertex.xy = ((u_xlat0.xy * in_v.color.xx) + u_xlat2.xy);
          u_xlat0.x = (0.00100000005 / u_xlat2.w);
          out_v.vertex.z = (u_xlat0.x + u_xlat2.z);
          out_v.texcoord1 = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat1);
          u_xlat0.x = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat0.y = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat0.z = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          out_v.vs_NORMAL0.xyz = normalize(u_xlat0.xyz);
          out_v.vertex.w = u_xlat2.w;
          out_v.texcoord.xy = in_v.texcoord.xy;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float3 u_xlat16_0;
      int u_xlatb0_d;
      float3 u_xlat1_d;
      float3 u_xlat16_2;
      int u_xlatb3;
      float u_xlat9;
      float u_xlat16_9;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0_d = (_useTNCartoonOutline==1);
          #else
          u_xlatb0_d = (_useTNCartoonOutline==1);
          #endif
          #ifdef UNITY_ADRENO_ES3
          u_xlatb3 = (_OutLine_Width==0);
          #else
          u_xlatb3 = (_OutLine_Width==0);
          #endif
          u_xlatb0_d = (u_xlatb3 || u_xlatb0_d);
          if(u_xlatb0_d)
          {
              if((int(4294967295)!=0))
              {
                  discard;
              }
              out_f.color = float4(0, 0, 0, 0);
              return out_f;
          }
          u_xlat0_d.xy = TRANSFORM_TEX(in_f.texcoord.xy, _MainTex);
          u_xlat16_0.xyz = tex2D(_MainTex, u_xlat0_d.xy).xyz;
          u_xlat16_9 = tex2D(_ShadowMap, in_f.texcoord.xy).x;
          u_xlat9 = (u_xlat16_9 * _useShadowMap_R);
          u_xlat1_d.xyz = ((-_OutLine_Color.xyz) + _OutLine_Color2.xyz);
          u_xlat1_d.xyz = ((float3(u_xlat9, u_xlat9, u_xlat9) * u_xlat1_d.xyz) + _OutLine_Color.xyz);
          u_xlat0_d.xyz = (u_xlat16_0.xyz * u_xlat1_d.xyz);
          u_xlat16_2.xyz = (_LightColor0.xyz + float3(0.300000012, 0.300000012, 0.300000012));
          out_f.color.xyz = (u_xlat0_d.xyz * u_xlat16_2.xyz);
          out_f.color.w = 1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: ForwardBase基底色
    {
      Name "ForwardBase基底色"
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
      }
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4 _Time;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _WorldSpaceLightPos0;
      uniform float4 _LightColor0;
      uniform float4 _MainTex_ST;
      uniform float4 _NormalMap_ST;
      uniform float _LdotN_End;
      uniform float _LdotN_Start;
      uniform float _Alpha;
      uniform float _useShadowMap_R;
      uniform float _useShadowMap_G;
      uniform float _useShadowMap_B;
      uniform float _Specular_pow;
      uniform float _useMetalMask;
      uniform float _useEmissionlMask;
      uniform float _Metal_Intensity;
      uniform float _LightWrap_Start;
      uniform float _LightWrap_End;
      uniform float _Normal_Intensity;
      uniform float _ShyPos;
      uniform float _ShySmooth;
      uniform float _useZumiShy;
      uniform float _RimThreshold;
      uniform float4 _MainColor;
      uniform float4 _ShadowColor;
      uniform float4 _ShadowColor2;
      uniform float4 _LightWrap1;
      uniform float4 _LightWrap2;
      uniform float4 _LightHair_Color;
      uniform float4 _NieoLight_Color;
      uniform float4 _SkinColor2;
      uniform float4 _Emission_Color;
      uniform float4 _ShyColor;
      uniform float4 _Color;
      uniform float4 _FluidLightVector;
      uniform float4 _RimColor;
      uniform sampler2D _MainTex;
      uniform sampler2D _ShadowMap;
      uniform sampler2D _Special_Mask;
      uniform sampler2D _NormalMap;
      uniform sampler2D _Metal_FLight_Emi_Map;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float2 texcoord :TEXCOORD0;
          float4 tangent :TANGENT0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
          float3 texcoord5 :TEXCOORD5;
          float4 color :COLOR0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
          float3 texcoord5 :TEXCOORD5;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float3 u_xlat16_2;
      float u_xlat9;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          out_v.texcoord = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat0);
          u_xlat0 = mul(unity_MatrixVP, u_xlat1);
          out_v.vertex = u_xlat0;
          out_v.texcoord1.xy = in_v.texcoord.xy;
          u_xlat0.x = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat0.y = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat0.z = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat0.xyz = normalize(u_xlat0.xyz);
          out_v.texcoord2.xyz = u_xlat0.xyz;
          u_xlat1.z = dot(in_v.tangent.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat1.x = dot(in_v.tangent.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat1.y = dot(in_v.tangent.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat1.xyz = normalize(u_xlat1.xyz);
          u_xlat16_2.xyz = (u_xlat0.zxy * u_xlat1.xyz);
          u_xlat16_2.xyz = ((u_xlat0.yzx * u_xlat1.yzx) + (-u_xlat16_2.xyz));
          u_xlat16_2.xyz = (u_xlat16_2.xyz * in_v.tangent.www);
          out_v.texcoord3.x = u_xlat16_2.x;
          out_v.texcoord3.z = u_xlat0.x;
          out_v.texcoord3.y = u_xlat1.z;
          out_v.texcoord4.y = u_xlat1.x;
          out_v.texcoord5.y = u_xlat1.y;
          out_v.texcoord4.z = u_xlat0.y;
          out_v.texcoord5.z = u_xlat0.z;
          out_v.texcoord4.x = u_xlat16_2.y;
          out_v.texcoord5.x = u_xlat16_2.z;
          out_v.color = in_v.color;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float3 u_xlat10_0;
      int u_xlatb0;
      float3 u_xlat16_1;
      float3 u_xlat16_2_d;
      float2 u_xlat3;
      float4 u_xlat10_3;
      float4 u_xlat4;
      float3 u_xlat10_4;
      float3 u_xlat16_5;
      float3 u_xlat16_6;
      float3 u_xlat16_7;
      float3 u_xlat16_8;
      float3 u_xlat9_d;
      int u_xlatb9;
      float u_xlat16_10;
      float3 u_xlat16_11;
      float3 u_xlat16_14;
      float u_xlat16_19;
      float u_xlat16_28;
      float u_xlat16_29;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = TRANSFORM_TEX(in_f.texcoord1.xy, _NormalMap);
          u_xlat10_0.xyz = tex2D(_NormalMap, u_xlat0_d.xy).xyz;
          u_xlat16_1.xyz = ((u_xlat10_0.xyz * float3(2, 2, 2)) + float3(-1, (-1), (-1)));
          u_xlat16_1.xy = (u_xlat16_1.xy * float2(float2(_Normal_Intensity, _Normal_Intensity)));
          u_xlat16_2_d.x = dot(u_xlat16_1.xyz, in_f.texcoord3.xyz);
          u_xlat16_2_d.y = dot(u_xlat16_1.xyz, in_f.texcoord4.xyz);
          u_xlat16_2_d.z = dot(u_xlat16_1.xyz, in_f.texcoord5.xyz);
          u_xlat16_1.x = dot(u_xlat16_2_d.xyz, u_xlat16_2_d.xyz);
          u_xlat16_1.x = rsqrt(u_xlat16_1.x);
          u_xlat16_1.xyz = (u_xlat16_1.xxx * u_xlat16_2_d.xyz);
          u_xlat0_d.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
          u_xlat0_d.x = rsqrt(u_xlat0_d.x);
          u_xlat9_d.xyz = (u_xlat0_d.xxx * _WorldSpaceLightPos0.xyz);
          u_xlat16_28 = dot(u_xlat9_d.xyz, u_xlat16_1.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_28 = min(max(u_xlat16_28, 0), 1);
          #else
          u_xlat16_28 = clamp(u_xlat16_28, 0, 1);
          #endif
          u_xlat16_2_d.x = (u_xlat16_28 * _useShadowMap_G);
          u_xlat16_11.xy = float2(((-float2(_useShadowMap_G, _useShadowMap_R)) + float2(1, 1)));
          u_xlat16_28 = (u_xlat16_28 * u_xlat16_11.x);
          u_xlat16_11.xyz = (u_xlat16_11.yyy * _ShadowColor.xyz);
          u_xlat3.xy = TRANSFORM_TEX(in_f.texcoord1.xy, _MainTex);
          u_xlat10_4.xyz = tex2D(_ShadowMap, u_xlat3.xy).xyz;
          u_xlat16_5.x = ((-u_xlat10_4.y) + 1);
          u_xlat16_28 = ((u_xlat16_2_d.x * u_xlat16_5.x) + u_xlat16_28);
          u_xlat16_2_d.x = (u_xlat16_28 + (-_LdotN_Start));
          u_xlat16_5.x = ((-_LdotN_Start) + _LdotN_End);
          u_xlat16_2_d.x = (u_xlat16_2_d.x / u_xlat16_5.x);
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_2_d.x = min(max(u_xlat16_2_d.x, 0), 1);
          #else
          u_xlat16_2_d.x = clamp(u_xlat16_2_d.x, 0, 1);
          #endif
          u_xlat16_5.xyz = ((-_ShadowColor.xyz) + _ShadowColor2.xyz);
          u_xlat16_5.xyz = ((u_xlat10_4.xxx * u_xlat16_5.xyz) + _ShadowColor.xyz);
          u_xlat16_11.xyz = ((float3(float3(_useShadowMap_R, _useShadowMap_R, _useShadowMap_R)) * u_xlat16_5.xyz) + u_xlat16_11.xyz);
          u_xlat16_6.xyz = tex2D(_MainTex, u_xlat3.xy).xyz;
          u_xlat10_3 = tex2D(_Special_Mask, u_xlat3.xy);
          u_xlat16_5.xyz = (u_xlat16_6.xyz * _MainColor.xyz);
          u_xlat16_11.xyz = ((u_xlat16_11.xyz * u_xlat16_6.xyz) + (-u_xlat16_5.xyz));
          u_xlat16_2_d.xyz = ((u_xlat16_2_d.xxx * u_xlat16_11.xyz) + u_xlat16_5.xyz);
          u_xlat16_29 = (u_xlat10_4.x * _useShadowMap_R);
          u_xlat16_7.xyz = ((-_LightWrap1.xyz) + _LightWrap2.xyz);
          u_xlat16_7.xyz = ((float3(u_xlat16_29, u_xlat16_29, u_xlat16_29) * u_xlat16_7.xyz) + _LightWrap1.xyz);
          u_xlat16_8.xy = float2((float2(_LdotN_Start, _LdotN_End) + float2(_LightWrap_Start, _LightWrap_End)));
          u_xlat16_28 = (u_xlat16_28 + (-u_xlat16_8.x));
          u_xlat16_29 = ((-u_xlat16_8.x) + u_xlat16_8.y);
          u_xlat16_28 = (u_xlat16_28 / u_xlat16_29);
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_28 = min(max(u_xlat16_28, 0), 1);
          #else
          u_xlat16_28 = clamp(u_xlat16_28, 0, 1);
          #endif
          u_xlat16_29 = ((-u_xlat16_28) + 1);
          u_xlat16_28 = (u_xlat16_28 * u_xlat16_29);
          u_xlat16_5.xyz = (u_xlat16_5.xyz * float3(u_xlat16_28, u_xlat16_28, u_xlat16_28));
          u_xlat16_5.xyz = (u_xlat16_7.xyz * u_xlat16_5.xyz);
          u_xlat16_2_d.xyz = ((u_xlat16_5.xyz * _LightColor0.xyz) + u_xlat16_2_d.xyz);
          u_xlat16_28 = dot(u_xlat16_2_d.xyz, float3(0.300000012, 0.300000012, 0.300000012));
          u_xlat16_5.xyz = ((float3(u_xlat16_28, u_xlat16_28, u_xlat16_28) * _SkinColor2.xyz) + (-u_xlat16_2_d.xyz));
          u_xlat16_28 = (u_xlat10_3.x * _SkinColor2.w);
          u_xlat16_2_d.xyz = ((float3(u_xlat16_28, u_xlat16_28, u_xlat16_28) * u_xlat16_5.xyz) + u_xlat16_2_d.xyz);
          u_xlat4.xyw = ((-in_f.texcoord.xyz) + _WorldSpaceCameraPos.xyz);
          u_xlat3.x = dot(u_xlat4.xyw, u_xlat4.xyw);
          u_xlat3.x = rsqrt(u_xlat3.x);
          u_xlat4.xyw = (u_xlat3.xxx * u_xlat4.xyw);
          u_xlat16_28 = dot(u_xlat4.xyw, u_xlat16_1.xyz);
          u_xlat16_29 = u_xlat16_28;
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_29 = min(max(u_xlat16_29, 0), 1);
          #else
          u_xlat16_29 = clamp(u_xlat16_29, 0, 1);
          #endif
          u_xlat16_29 = ((-u_xlat16_29) + 0.5);
          u_xlat16_29 = (u_xlat16_29 * 4);
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_29 = min(max(u_xlat16_29, 0), 1);
          #else
          u_xlat16_29 = clamp(u_xlat16_29, 0, 1);
          #endif
          u_xlat16_5.x = dot(u_xlat9_d.xyz, (-u_xlat4.xyw));
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_5.x = min(max(u_xlat16_5.x, 0), 1);
          #else
          u_xlat16_5.x = clamp(u_xlat16_5.x, 0, 1);
          #endif
          u_xlat16_14.xyz = ((_WorldSpaceLightPos0.xyz * u_xlat0_d.xxx) + u_xlat4.xyw);
          u_xlat16_29 = (u_xlat16_29 * u_xlat16_5.x);
          u_xlat16_7.xyz = (u_xlat16_6.xyz * float3(u_xlat16_29, u_xlat16_29, u_xlat16_29));
          u_xlat16_7.xyz = (u_xlat16_7.xyz * in_f.color.xxx);
          u_xlat16_2_d.xyz = ((u_xlat16_7.xyz * float3(0.699999988, 0.699999988, 0.699999988)) + u_xlat16_2_d.xyz);
          u_xlat16_7.xyz = (_LightColor0.xyz + float3(0.300000012, 0.300000012, 0.300000012));
          u_xlat16_2_d.xyz = (u_xlat16_2_d.xyz * u_xlat16_7.xyz);
          u_xlat16_5.xyz = normalize(u_xlat16_14.xyz);
          u_xlat16_1.x = dot(u_xlat16_5.xyz, u_xlat16_1.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_1.x = min(max(u_xlat16_1.x, 0), 1);
          #else
          u_xlat16_1.x = clamp(u_xlat16_1.x, 0, 1);
          #endif
          u_xlat16_10 = log2(u_xlat16_1.x);
          u_xlat16_19 = (_Specular_pow * 100);
          u_xlat16_10 = (u_xlat16_10 * u_xlat16_19);
          u_xlat16_10 = exp2(u_xlat16_10);
          u_xlat10_0.xy = tex2D(_Metal_FLight_Emi_Map, in_f.texcoord1.xy).xz;
          u_xlat16_5.xy = (u_xlat10_0.yx * float2(_useEmissionlMask, _useMetalMask));
          u_xlat16_14.xyz = (u_xlat16_5.yyy * _LightColor0.xyz);
          u_xlat16_7.xyz = (u_xlat16_6.xyz * u_xlat16_5.xxx);
          u_xlat16_5.xyz = (float3(u_xlat16_10, u_xlat16_10, u_xlat16_10) * u_xlat16_14.xyz);
          u_xlat16_5.xyz = ((u_xlat16_5.xyz * float3(float3(_Metal_Intensity, _Metal_Intensity, _Metal_Intensity))) + u_xlat16_2_d.xyz);
          u_xlat0_d.x = sin(_Time.y);
          u_xlat0_d.x = max(u_xlat0_d.x, 0);
          u_xlat0_d.xyz = (u_xlat0_d.xxx * u_xlat16_7.xyz);
          u_xlat0_d.xyz = (u_xlat0_d.xyz * _Emission_Color.xyz);
          u_xlat16_5.xyz = ((u_xlat0_d.xyz * _Emission_Color.www) + u_xlat16_5.xyz);
          u_xlat16_10 = (u_xlat16_1.x * u_xlat16_1.x);
          u_xlat16_10 = (u_xlat16_10 * u_xlat16_10);
          u_xlat16_1.x = (u_xlat16_10 * u_xlat16_1.x);
          u_xlat16_1.x = (u_xlat16_1.x * _useShadowMap_B);
          u_xlat16_1.x = (u_xlat10_4.z * u_xlat16_1.x);
          u_xlat16_1.xyz = ((u_xlat16_1.xxx * _LightHair_Color.xyz) + u_xlat16_5.xyz);
          u_xlat16_5.xyz = float3((float3(u_xlat16_28, u_xlat16_28, u_xlat16_28) + float3(0, 0.330000013, 0.660000026)));
          u_xlat16_28 = ((-u_xlat16_28) + 1);
          u_xlat16_7.xyz = (float3(u_xlat16_28, u_xlat16_28, u_xlat16_28) * _RimColor.xyz);
          u_xlat16_5.xyz = frac(u_xlat16_5.xyz);
          u_xlat16_5.xyz = (((-u_xlat16_5.xyz) * float3(2, 2, 2)) + float3(1, 1, 1));
          u_xlat16_5.xyz = ((abs(u_xlat16_5.xyz) * float3(3, 3, 3)) + float3(-1, (-1), (-1)));
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0), 1);
          #else
          u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0, 1);
          #endif
          u_xlat16_5.xyz = ((-u_xlat16_5.xyz) + float3(1, 1, 1));
          u_xlat16_8.xyz = ((-_NieoLight_Color.xyz) + float3(1, 1, 1));
          u_xlat16_5.xyz = (((-u_xlat16_5.xyz) * u_xlat16_8.xyz) + float3(1, 1, 1));
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0), 1);
          #else
          u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0, 1);
          #endif
          u_xlat16_5.xyz = (u_xlat16_5.xyz * _NieoLight_Color.www);
          u_xlat16_1.xyz = ((u_xlat16_5.xyz * u_xlat10_3.yyy) + u_xlat16_1.xyz);
          u_xlat0_d.x = (_Time.y * _FluidLightVector.x);
          u_xlat0_d.x = ((in_f.texcoord1.y * 3.1400001) + u_xlat0_d.x);
          u_xlat0_d.x = sin(u_xlat0_d.x);
          u_xlat0_d.x = log2(abs(u_xlat0_d.x));
          u_xlat0_d.x = (u_xlat0_d.x * _FluidLightVector.y);
          u_xlat0_d.x = exp2(u_xlat0_d.x);
          u_xlat16_28 = sin(u_xlat0_d.x);
          u_xlat16_28 = (u_xlat16_28 * u_xlat10_3.w);
          u_xlat16_28 = (u_xlat16_28 * _FluidLightVector.z);
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_28 = min(max(u_xlat16_28, 0), 1);
          #else
          u_xlat16_28 = clamp(u_xlat16_28, 0, 1);
          #endif
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0 = (_FluidLightVector.w==1);
          #else
          u_xlatb0 = (_FluidLightVector.w==1);
          #endif
          u_xlat16_28 = (u_xlatb0)?(u_xlat16_28):(0);
          u_xlat16_1.xyz = ((float3(u_xlat16_28, u_xlat16_28, u_xlat16_28) * u_xlat16_2_d.xyz) + u_xlat16_1.xyz);
          u_xlat16_1.xyz = ((u_xlat16_7.xyz * float3(_RimThreshold, _RimThreshold, _RimThreshold)) + u_xlat16_1.xyz);
          u_xlat16_1.xyz = (u_xlat16_1.xyz * _Color.xyz);
          u_xlat0_d.x = (in_f.texcoord1.y + _ShyPos);
          #ifdef UNITY_ADRENO_ES3
          u_xlat0_d.x = min(max(u_xlat0_d.x, 0), 1);
          #else
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0, 1);
          #endif
          u_xlat0_d.x = log2(u_xlat0_d.x);
          u_xlat0_d.x = (u_xlat0_d.x * 10);
          u_xlat0_d.x = exp2(u_xlat0_d.x);
          u_xlat0_d.x = ((-u_xlat0_d.x) + 1);
          u_xlat16_2_d.xyz = (u_xlat0_d.xxx * _ShyColor.xyz);
          u_xlat16_2_d.xyz = (u_xlat16_2_d.xyz * _ShyColor.www);
          u_xlat16_2_d.xyz = (u_xlat10_3.zzz * u_xlat16_2_d.xyz);
          u_xlat16_28 = (u_xlat10_3.z * _ShySmooth);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb9 = (float4(0, 0, 0, 0).x != float4(_useZumiShy, _useZumiShy, _useZumiShy, _useZumiShy).x && float4(0, 0, 0, 0).y != float4(_useZumiShy, _useZumiShy, _useZumiShy, _useZumiShy).y && float4(0, 0, 0, 0).z != float4(_useZumiShy, _useZumiShy, _useZumiShy, _useZumiShy).z && float4(0, 0, 0, 0).w != float4(_useZumiShy, _useZumiShy, _useZumiShy, _useZumiShy).w);
          #else
          u_xlatb9 = (float4(0, 0, 0, 0).x != float4(_useZumiShy, _useZumiShy, _useZumiShy, _useZumiShy).x && float4(0, 0, 0, 0).y != float4(_useZumiShy, _useZumiShy, _useZumiShy, _useZumiShy).y && float4(0, 0, 0, 0).z != float4(_useZumiShy, _useZumiShy, _useZumiShy, _useZumiShy).z && float4(0, 0, 0, 0).w != float4(_useZumiShy, _useZumiShy, _useZumiShy, _useZumiShy).w);
          #endif
          u_xlat16_2_d.xyz = (int(u_xlatb9))?(u_xlat16_2_d.xyz):(float3(0, 0, 0));
          u_xlat16_2_d.xyz = (u_xlat16_2_d.xyz + float3(1, 1, 1));
          u_xlat16_29 = (u_xlatb9)?(u_xlat0_d.x):(0);
          u_xlat16_2_d.xyz = ((-float3(u_xlat16_29, u_xlat16_29, u_xlat16_29)) + u_xlat16_2_d.xyz);
          u_xlat16_2_d.xyz = ((u_xlat16_1.xyz * u_xlat16_2_d.xyz) + (-u_xlat16_1.xyz));
          u_xlat16_2_d.xyz = ((float3(u_xlat16_28, u_xlat16_28, u_xlat16_28) * u_xlat16_2_d.xyz) + u_xlat16_1.xyz);
          out_f.color.xyz = (int(u_xlatb9))?(u_xlat16_2_d.xyz):(u_xlat16_1.xyz);
          out_f.color.w = _Alpha;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: ForwardAdd點光源
    {
      Name "ForwardAdd點光源"
      Tags
      { 
        "LIGHTMODE" = "FORWARDADD"
      }
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
      //uniform float4x4 unity_MatrixVP;
      uniform float4x4 unity_WorldToLight;
      uniform float4 _LightColor0;
      uniform float4 _MainTex_ST;
      uniform float4 _MainColor;
      uniform float _Alpha;
      uniform sampler2D _LightTexture0;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float4 texcoord3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat0);
          u_xlat1 = mul(unity_MatrixVP, u_xlat1);
          out_v.vertex = u_xlat1;
          out_v.texcoord = u_xlat0;
          out_v.texcoord1.xy = in_v.texcoord.xy;
          u_xlat1.xyz = (u_xlat0.yyy * conv_mxt4x4_1(unity_WorldToLight).xyz);
          u_xlat1.xyz = ((conv_mxt4x4_0(unity_WorldToLight).xyz * u_xlat0.xxx) + u_xlat1.xyz);
          u_xlat0.xyz = ((conv_mxt4x4_2(unity_WorldToLight).xyz * u_xlat0.zzz) + u_xlat1.xyz);
          out_v.texcoord2.xyz = ((conv_mxt4x4_3(unity_WorldToLight).xyz * u_xlat0.www) + u_xlat0.xyz);
          out_v.texcoord3 = float4(0, 0, 0, 0);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float3 u_xlat16_0;
      float3 u_xlat16_1;
      float3 u_xlat16_2;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = TRANSFORM_TEX(in_f.texcoord1.xy, _MainTex);
          u_xlat16_0.xyz = tex2D(_MainTex, u_xlat0_d.xy).xyz;
          u_xlat16_1.xyz = (u_xlat16_0.xyz * _MainColor.xyz);
          u_xlat0_d.xyz = (in_f.texcoord.yyy * conv_mxt4x4_1(unity_WorldToLight).xyz);
          u_xlat0_d.xyz = ((conv_mxt4x4_0(unity_WorldToLight).xyz * in_f.texcoord.xxx) + u_xlat0_d.xyz);
          u_xlat0_d.xyz = ((conv_mxt4x4_2(unity_WorldToLight).xyz * in_f.texcoord.zzz) + u_xlat0_d.xyz);
          u_xlat0_d.xyz = (u_xlat0_d.xyz + conv_mxt4x4_3(unity_WorldToLight).xyz);
          u_xlat0_d.x = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          u_xlat0_d.x = tex2D(_LightTexture0, u_xlat0_d.xx).x;
          u_xlat16_2.xyz = (u_xlat0_d.xxx * _LightColor0.xyz);
          out_f.color.w = (u_xlat0_d.x * _Alpha);
          out_f.color.xyz = (u_xlat16_1.xyz * u_xlat16_2.xyz);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 4, name: ShadowCaster陰影投射
    {
      Name "ShadowCaster陰影投射"
      Tags
      { 
        "LIGHTMODE" = "SHADOWCASTER"
        "SHADOWSUPPORT" = "true"
      }
      Cull Off
      Offset 1, 1
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile SHADOWS_DEPTH
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 unity_LightShadowBias;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      struct appdata_t
      {
          float4 vertex :POSITION0;
      };
      
      struct OUT_Data_Vert
      {
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 vertex :Position;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float u_xlat4;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = UnityObjectToClipPos(in_v.vertex);
          u_xlat1.x = (unity_LightShadowBias.x / u_xlat0.w);
          #ifdef UNITY_ADRENO_ES3
          u_xlat1.x = min(max(u_xlat1.x, 0), 1);
          #else
          u_xlat1.x = clamp(u_xlat1.x, 0, 1);
          #endif
          u_xlat4 = (u_xlat0.z + u_xlat1.x);
          u_xlat1.x = max((-u_xlat0.w), u_xlat4);
          out_v.vertex.xyw = u_xlat0.xyw;
          u_xlat0.x = ((-u_xlat4) + u_xlat1.x);
          out_v.vertex.z = ((unity_LightShadowBias.y * u_xlat0.x) + u_xlat4);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          out_f.color = float4(0, 0, 0, 0);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "ToonTwoStepsShader"
}
