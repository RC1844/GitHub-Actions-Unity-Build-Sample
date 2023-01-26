Shader "UnityChanToonShader/Toon_DoubleShadeWithFeather"
{
  Properties
  {
    [Enum(OFF,0,FRONT,1,BACK,2)] _CullMode ("Cull Mode", float) = 2
    _MainTex ("BaseMap", 2D) = "white" {}
    _BaseColor ("BaseColor", Color) = (1,1,1,1)
    [HideInInspector] _Color ("Color", Color) = (1,1,1,1)
    [MaterialToggle] _Is_LightColor_Base ("Is_LightColor_Base", float) = 1
    _1st_ShadeMap ("1st_ShadeMap", 2D) = "white" {}
    [MaterialToggle] _Use_BaseAs1st ("Use BaseMap as 1st_ShadeMap", float) = 0
    _1st_ShadeColor ("1st_ShadeColor", Color) = (1,1,1,1)
    [MaterialToggle] _Is_LightColor_1st_Shade ("Is_LightColor_1st_Shade", float) = 1
    _2nd_ShadeMap ("2nd_ShadeMap", 2D) = "white" {}
    [MaterialToggle] _Use_1stAs2nd ("Use 1st_ShadeMap as 2nd_ShadeMap", float) = 0
    _2nd_ShadeColor ("2nd_ShadeColor", Color) = (1,1,1,1)
    [MaterialToggle] _Is_LightColor_2nd_Shade ("Is_LightColor_2nd_Shade", float) = 1
    _NormalMap ("NormalMap", 2D) = "bump" {}
    [MaterialToggle] _Is_NormalMapToBase ("Is_NormalMapToBase", float) = 0
    [MaterialToggle] _Set_SystemShadowsToBase ("Set_SystemShadowsToBase", float) = 1
    _Tweak_SystemShadowsLevel ("Tweak_SystemShadowsLevel", Range(-0.5, 0.5)) = 0
    _BaseColor_Step ("BaseColor_Step", Range(0, 1)) = 0.5
    _BaseShade_Feather ("Base/Shade_Feather", Range(0.0001, 1)) = 0.0001
    _ShadeColor_Step ("ShadeColor_Step", Range(0, 1)) = 0
    _1st2nd_Shades_Feather ("1st/2nd_Shades_Feather", Range(0.0001, 1)) = 0.0001
    _StepOffset ("Step_Offset (ForwardAdd Only)", Range(-0.5, 0.5)) = 0
    [MaterialToggle] _Is_Filter_HiCutPointLightColor ("PointLights HiCut_Filter (ForwardAdd Only)", float) = 1
    _Set_1st_ShadePosition ("Set_1st_ShadePosition", 2D) = "white" {}
    _Set_2nd_ShadePosition ("Set_2nd_ShadePosition", 2D) = "white" {}
    _HighColor ("HighColor", Color) = (0,0,0,1)
    _HighColor_Tex ("HighColor_Tex", 2D) = "white" {}
    [MaterialToggle] _Is_LightColor_HighColor ("Is_LightColor_HighColor", float) = 1
    [MaterialToggle] _Is_NormalMapToHighColor ("Is_NormalMapToHighColor", float) = 0
    _HighColor_Power ("HighColor_Power", Range(0, 1)) = 0
    [MaterialToggle] _Is_SpecularToHighColor ("Is_SpecularToHighColor", float) = 0
    [MaterialToggle] _Is_BlendAddToHiColor ("Is_BlendAddToHiColor", float) = 0
    [MaterialToggle] _Is_UseTweakHighColorOnShadow ("Is_UseTweakHighColorOnShadow", float) = 0
    _TweakHighColorOnShadow ("TweakHighColorOnShadow", Range(0, 1)) = 0
    _Set_HighColorMask ("Set_HighColorMask", 2D) = "white" {}
    _Tweak_HighColorMaskLevel ("Tweak_HighColorMaskLevel", Range(-1, 1)) = 0
    [MaterialToggle] _RimLight ("RimLight", float) = 0
    _RimLightColor ("RimLightColor", Color) = (1,1,1,1)
    [MaterialToggle] _Is_LightColor_RimLight ("Is_LightColor_RimLight", float) = 1
    [MaterialToggle] _Is_NormalMapToRimLight ("Is_NormalMapToRimLight", float) = 0
    _RimLight_Power ("RimLight_Power", Range(0, 1)) = 0.1
    _RimLight_InsideMask ("RimLight_InsideMask", Range(0.0001, 1)) = 0.0001
    [MaterialToggle] _RimLight_FeatherOff ("RimLight_FeatherOff", float) = 0
    [MaterialToggle] _LightDirection_MaskOn ("LightDirection_MaskOn", float) = 0
    _Tweak_LightDirection_MaskLevel ("Tweak_LightDirection_MaskLevel", Range(0, 0.5)) = 0
    [MaterialToggle] _Add_Antipodean_RimLight ("Add_Antipodean_RimLight", float) = 0
    _Ap_RimLightColor ("Ap_RimLightColor", Color) = (1,1,1,1)
    [MaterialToggle] _Is_LightColor_Ap_RimLight ("Is_LightColor_Ap_RimLight", float) = 1
    _Ap_RimLight_Power ("Ap_RimLight_Power", Range(0, 1)) = 0.1
    [MaterialToggle] _Ap_RimLight_FeatherOff ("Ap_RimLight_FeatherOff", float) = 0
    _Set_RimLightMask ("Set_RimLightMask", 2D) = "white" {}
    _Tweak_RimLightMaskLevel ("Tweak_RimLightMaskLevel", Range(-1, 1)) = 0
    [MaterialToggle] _MatCap ("MatCap", float) = 0
    _MatCap_Sampler ("MatCap_Sampler", 2D) = "black" {}
    _MatCapColor ("MatCapColor", Color) = (1,1,1,1)
    [MaterialToggle] _Is_LightColor_MatCap ("Is_LightColor_MatCap", float) = 1
    [MaterialToggle] _Is_BlendAddToMatCap ("Is_BlendAddToMatCap", float) = 1
    _Tweak_MatCapUV ("Tweak_MatCapUV", Range(-0.5, 0.5)) = 0
    _Rotate_MatCapUV ("Rotate_MatCapUV", Range(-1, 1)) = 0
    [MaterialToggle] _Is_NormalMapForMatCap ("Is_NormalMapForMatCap", float) = 0
    _NormalMapForMatCap ("NormalMapForMatCap", 2D) = "bump" {}
    _Rotate_NormalMapForMatCapUV ("Rotate_NormalMapForMatCapUV", Range(-1, 1)) = 0
    [MaterialToggle] _Is_UseTweakMatCapOnShadow ("Is_UseTweakMatCapOnShadow", float) = 0
    _TweakMatCapOnShadow ("TweakMatCapOnShadow", Range(0, 1)) = 0
    _Set_MatcapMask ("Set_MatcapMask", 2D) = "white" {}
    _Tweak_MatcapMaskLevel ("Tweak_MatcapMaskLevel", Range(-1, 1)) = 0
    [MaterialToggle] _Is_Ortho ("Orthographic Projection for MatCap", float) = 0
    _Emissive_Tex ("Emissive_Tex", 2D) = "white" {}
    [HDR] _Emissive_Color ("Emissive_Color", Color) = (0,0,0,1)
    [KeywordEnum(NML,POS)] _OUTLINE ("OUTLINE MODE", float) = 0
    _Outline_Width ("Outline_Width", float) = 1
    _Farthest_Distance ("Farthest_Distance", float) = 10
    _Nearest_Distance ("Nearest_Distance", float) = 0.5
    _Outline_Sampler ("Outline_Sampler", 2D) = "white" {}
    _Outline_Color ("Outline_Color", Color) = (0.5,0.5,0.5,1)
    [MaterialToggle] _Is_BlendBaseColor ("Is_BlendBaseColor", float) = 0
    [MaterialToggle] _Is_OutlineTex ("Is_OutlineTex", float) = 0
    _OutlineTex ("OutlineTex", 2D) = "white" {}
    _Offset_Z ("Offset_Camera_Z", float) = 0
    [MaterialToggle] _Is_BakedNormal ("Is_BakedNormal", float) = 0
    _BakedNormal ("Baked Normal for Outline", 2D) = "white" {}
    _GI_Intensity ("GI_Intensity", Range(0, 1)) = 0
    _Unlit_Intensity ("Unlit_Intensity", Range(0.001, 2)) = 1
    [MaterialToggle] _Is_Filter_LightColor ("VRChat : SceneLights HiCut_Filter", float) = 0
    [HideInInspector] _ColorBoost (" *Advanced Option : Compensation Boost", Range(1, 5)) = 1
    [MaterialToggle] _Is_BLD ("Advanced : Activate Built-in Light Direction", float) = 0
    _Offset_X_Axis_BLD (" Offset X-Axis (Built-in Light Direction)", Range(-1, 1)) = -0.05
    _Offset_Y_Axis_BLD (" Offset Y-Axis (Built-in Light Direction)", Range(-1, 1)) = 0.09
    [MaterialToggle] _Inverse_Z_Axis_BLD (" Inverse Z-Axis (Built-in Light Direction)", float) = 1
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    Pass // ind: 1, name: Outline
    {
      Name "Outline"
      Tags
      { 
        "RenderType" = "Opaque"
      }
      Cull Front
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile _IS_OUTLINE_CLIPPING_NO _OUTLINE_NML
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      uniform float _Outline_Width;
      uniform float _Farthest_Distance;
      uniform float _Nearest_Distance;
      uniform float4 _Outline_Sampler_ST;
      uniform float _Offset_Z;
      uniform float4 _BakedNormal_ST;
      uniform float _Is_BakedNormal;
      uniform sampler2D _Outline_Sampler;
      uniform sampler2D _BakedNormal;
      uniform float4 _LightColor0;
      uniform float4 _BaseColor;
      uniform float4 _MainTex_ST;
      uniform float4 _Outline_Color;
      uniform float _Is_BlendBaseColor;
      uniform float _Is_LightColor_Base;
      uniform float4 _OutlineTex_ST;
      uniform float _Is_OutlineTex;
      uniform sampler2D _MainTex;
      uniform sampler2D _OutlineTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 tangent :TANGENT0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
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
      float3 u_xlat2;
      float3 u_xlat3;
      float3 u_xlat4;
      float3 u_xlat5;
      float u_xlat16;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.xyz = ((-_WorldSpaceCameraPos.xyz) + conv_mxt4x4_3(unity_ObjectToWorld).xyz);
          u_xlat0.x = length(u_xlat0.xyz);
          u_xlat0.x = (u_xlat0.x + (-_Farthest_Distance));
          u_xlat5.x = ((-_Farthest_Distance) + _Nearest_Distance);
          u_xlat5.x = (float(1) / u_xlat5.x);
          u_xlat0.x = (u_xlat5.x * u_xlat0.x);
          #ifdef UNITY_ADRENO_ES3
          u_xlat0.x = min(max(u_xlat0.x, 0), 1);
          #else
          u_xlat0.x = clamp(u_xlat0.x, 0, 1);
          #endif
          u_xlat5.x = ((u_xlat0.x * (-2)) + 3);
          u_xlat0.x = (u_xlat0.x * u_xlat0.x);
          u_xlat0.x = (u_xlat0.x * u_xlat5.x);
          u_xlat5.x = (_Outline_Width * 0.00100000005);
          u_xlat0.x = (u_xlat0.x * u_xlat5.x);
          u_xlat5.xy = TRANSFORM_TEX(in_v.texcoord.xy, _Outline_Sampler);
          u_xlat5.x = tex2Dlod(_Outline_Sampler, float4(float3(u_xlat5.xy, 0), 0)).x;
          u_xlat0.x = (u_xlat5.x * u_xlat0.x);
          u_xlat1.x = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat1.y = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat1.z = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
          u_xlat5.x = rsqrt(u_xlat5.x);
          u_xlat5.xyz = (u_xlat5.xxx * u_xlat1.xyz);
          u_xlat1.xyz = (in_v.tangent.yyy * conv_mxt4x4_1(unity_ObjectToWorld).xyz);
          u_xlat1.xyz = ((conv_mxt4x4_0(unity_ObjectToWorld).xyz * in_v.tangent.xxx) + u_xlat1.xyz);
          u_xlat1.xyz = ((conv_mxt4x4_2(unity_ObjectToWorld).xyz * in_v.tangent.zzz) + u_xlat1.xyz);
          u_xlat1.xyz = normalize(u_xlat1.xyz);
          u_xlat2.xyz = (u_xlat5.zxy * u_xlat1.yzx);
          u_xlat2.xyz = ((u_xlat5.yzx * u_xlat1.zxy) + (-u_xlat2.xyz));
          u_xlat2.xyz = (u_xlat2.xyz * in_v.tangent.www);
          u_xlat2.xyz = normalize(u_xlat2.xyz);
          u_xlat3.xy = TRANSFORM_TEX(in_v.texcoord.xy, _BakedNormal);
          u_xlat3.xyz = tex2Dlod(_BakedNormal, float4(float3(u_xlat3.xy, 0), 0)).xyz;
          u_xlat3.xyz = ((u_xlat3.xyz * float3(2, 2, 2)) + float3(-1, (-1), (-1)));
          u_xlat4.xyz = (u_xlat2.xyz * u_xlat3.yyy);
          out_v.texcoord3.xyz = u_xlat2.xyz;
          u_xlat2.xyz = ((u_xlat3.xxx * u_xlat1.xyz) + u_xlat4.xyz);
          out_v.texcoord2.xyz = u_xlat1.xyz;
          u_xlat1.xyz = ((u_xlat3.zzz * u_xlat5.xyz) + u_xlat2.xyz);
          out_v.texcoord1.xyz = u_xlat5.xyz;
          u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
          u_xlat5.x = rsqrt(u_xlat5.x);
          u_xlat5.xyz = (u_xlat5.xxx * u_xlat1.xyz);
          u_xlat5.xyz = ((u_xlat5.xyz * u_xlat0.xxx) + in_v.vertex.xyz);
          u_xlat1.xyz = ((in_v.normal.xyz * u_xlat0.xxx) + in_v.vertex.xyz);
          u_xlat0.xyz = (u_xlat5.xyz + (-u_xlat1.xyz));
          u_xlat0.xyz = ((float3(_Is_BakedNormal, _Is_BakedNormal, _Is_BakedNormal) * u_xlat0.xyz) + u_xlat1.xyz);
          u_xlat0 = UnityObjectToClipPos(u_xlat0);
          u_xlat1.x = (_WorldSpaceCameraPos.y * conv_mxt4x4_1(unity_MatrixVP).z);
          u_xlat1.x = ((conv_mxt4x4_0(unity_MatrixVP).z * _WorldSpaceCameraPos.x) + u_xlat1.x);
          u_xlat1.x = ((conv_mxt4x4_2(unity_MatrixVP).z * _WorldSpaceCameraPos.z) + u_xlat1.x);
          u_xlat1.x = (u_xlat1.x + conv_mxt4x4_3(unity_MatrixVP).z);
          u_xlat1.x = (u_xlat1.x * _Offset_Z);
          out_v.vertex.z = ((u_xlat1.x * (-0.00999999978)) + u_xlat0.z);
          out_v.vertex.xyw = u_xlat0.xyw;
          out_v.texcoord.xy = in_v.texcoord.xy;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float3 u_xlat16_0;
      float3 u_xlat1_d;
      float3 u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = TRANSFORM_TEX(in_f.texcoord.xy, _MainTex);
          u_xlat16_0.xyz = tex2D(_MainTex, u_xlat0_d.xy).xyz;
          u_xlat0_d.xyz = (u_xlat16_0.xyz * _BaseColor.xyz);
          u_xlat1_d.xyz = _LightColor0.xyz;
          #ifdef UNITY_ADRENO_ES3
          u_xlat1_d.xyz = min(max(u_xlat1_d.xyz, 0), 1);
          #else
          u_xlat1_d.xyz = clamp(u_xlat1_d.xyz, 0, 1);
          #endif
          u_xlat1_d.xyz = ((u_xlat0_d.xyz * u_xlat1_d.xyz) + (-u_xlat0_d.xyz));
          u_xlat0_d.xyz = ((float3(float3(_Is_LightColor_Base, _Is_LightColor_Base, _Is_LightColor_Base)) * u_xlat1_d.xyz) + u_xlat0_d.xyz);
          u_xlat0_d.xyz = (u_xlat0_d.xyz * u_xlat0_d.xyz);
          u_xlat0_d.xyz = ((u_xlat0_d.xyz * _Outline_Color.xyz) + (-_Outline_Color.xyz));
          u_xlat0_d.xyz = ((float3(_Is_BlendBaseColor, _Is_BlendBaseColor, _Is_BlendBaseColor) * u_xlat0_d.xyz) + _Outline_Color.xyz);
          u_xlat1_d.xy = TRANSFORM_TEX(in_f.texcoord.xy, _OutlineTex);
          u_xlat16_1.xyz = tex2D(_OutlineTex, u_xlat1_d.xy).xyz;
          u_xlat1_d.xyz = ((u_xlat16_1.xyz * u_xlat0_d.xyz) + (-u_xlat0_d.xyz));
          out_f.color.xyz = ((float3(_Is_OutlineTex, _Is_OutlineTex, _Is_OutlineTex) * u_xlat1_d.xyz) + u_xlat0_d.xyz);
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
        "LIGHTMODE" = "FORWARDBASE"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile DIRECTIONAL _IS_CLIPPING_OFF _IS_PASS_FWDBASE
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
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _WorldSpaceLightPos0;
      //uniform float4 unity_SHAr;
      //uniform float4 unity_SHAg;
      //uniform float4 unity_SHAb;
      //uniform float4 unity_SHBr;
      //uniform float4 unity_SHBg;
      //uniform float4 unity_SHBb;
      //uniform float4 unity_SHC;
      //uniform float4x4 unity_MatrixV;
      uniform float4 _LightColor0;
      uniform float4 _MainTex_ST;
      uniform float4 _BaseColor;
      uniform float _Use_BaseAs1st;
      uniform float _Use_1stAs2nd;
      uniform float _Is_LightColor_Base;
      uniform float4 _1st_ShadeMap_ST;
      uniform float4 _1st_ShadeColor;
      uniform float _Is_LightColor_1st_Shade;
      uniform float4 _2nd_ShadeMap_ST;
      uniform float4 _2nd_ShadeColor;
      uniform float _Is_LightColor_2nd_Shade;
      uniform float4 _NormalMap_ST;
      uniform float _Is_NormalMapToBase;
      uniform float _Set_SystemShadowsToBase;
      uniform float _Tweak_SystemShadowsLevel;
      uniform float _BaseColor_Step;
      uniform float _BaseShade_Feather;
      uniform float4 _Set_1st_ShadePosition_ST;
      uniform float _ShadeColor_Step;
      uniform float _1st2nd_Shades_Feather;
      uniform float4 _Set_2nd_ShadePosition_ST;
      uniform float4 _HighColor;
      uniform float4 _HighColor_Tex_ST;
      uniform float _Is_LightColor_HighColor;
      uniform float _Is_NormalMapToHighColor;
      uniform float _HighColor_Power;
      uniform float _Is_SpecularToHighColor;
      uniform float _Is_BlendAddToHiColor;
      uniform float _Is_UseTweakHighColorOnShadow;
      uniform float _TweakHighColorOnShadow;
      uniform float4 _Set_HighColorMask_ST;
      uniform float _Tweak_HighColorMaskLevel;
      uniform float _RimLight;
      uniform float4 _RimLightColor;
      uniform float _Is_LightColor_RimLight;
      uniform float _Is_NormalMapToRimLight;
      uniform float _RimLight_Power;
      uniform float _RimLight_InsideMask;
      uniform float _RimLight_FeatherOff;
      uniform float _LightDirection_MaskOn;
      uniform float _Tweak_LightDirection_MaskLevel;
      uniform float _Add_Antipodean_RimLight;
      uniform float4 _Ap_RimLightColor;
      uniform float _Is_LightColor_Ap_RimLight;
      uniform float _Ap_RimLight_Power;
      uniform float _Ap_RimLight_FeatherOff;
      uniform float4 _Set_RimLightMask_ST;
      uniform float _Tweak_RimLightMaskLevel;
      uniform float _MatCap;
      uniform float4 _MatCap_Sampler_ST;
      uniform float4 _MatCapColor;
      uniform float _Is_LightColor_MatCap;
      uniform float _Is_BlendAddToMatCap;
      uniform float _Tweak_MatCapUV;
      uniform float _Rotate_MatCapUV;
      uniform float _Is_NormalMapForMatCap;
      uniform float4 _NormalMapForMatCap_ST;
      uniform float _Rotate_NormalMapForMatCapUV;
      uniform float _Is_UseTweakMatCapOnShadow;
      uniform float _TweakMatCapOnShadow;
      uniform float4 _Set_MatcapMask_ST;
      uniform float _Tweak_MatcapMaskLevel;
      uniform float _Is_Ortho;
      uniform float4 _Emissive_Tex_ST;
      uniform float4 _Emissive_Color;
      uniform float _Unlit_Intensity;
      uniform float _Is_Filter_LightColor;
      uniform float _Is_BLD;
      uniform float _Offset_X_Axis_BLD;
      uniform float _Offset_Y_Axis_BLD;
      uniform float _Inverse_Z_Axis_BLD;
      uniform float _GI_Intensity;
      uniform sampler2D _NormalMap;
      uniform sampler2D _MainTex;
      uniform sampler2D _1st_ShadeMap;
      uniform sampler2D _2nd_ShadeMap;
      uniform sampler2D _Set_2nd_ShadePosition;
      uniform sampler2D _Set_1st_ShadePosition;
      uniform sampler2D _Set_HighColorMask;
      uniform sampler2D _HighColor_Tex;
      uniform sampler2D _Set_RimLightMask;
      uniform sampler2D _NormalMapForMatCap;
      uniform sampler2D _MatCap_Sampler;
      uniform sampler2D _Set_MatcapMask;
      uniform sampler2D _Emissive_Tex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 tangent :TANGENT0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
      };
      
      struct OUT_Data_Frag
      {
          float4 SV_TARGET0 :SV_TARGET0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float3 u_xlat2;
      float u_xlat9;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          out_v.texcoord1 = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat0);
          out_v.vertex = mul(unity_MatrixVP, u_xlat1);
          out_v.texcoord.xy = in_v.texcoord.xy;
          u_xlat0.x = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat0.y = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat0.z = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat0.xyz = normalize(u_xlat0.xyz);
          out_v.texcoord2.xyz = u_xlat0.xyz;
          u_xlat1.xyz = (in_v.tangent.yyy * conv_mxt4x4_1(unity_ObjectToWorld).xyz);
          u_xlat1.xyz = ((conv_mxt4x4_0(unity_ObjectToWorld).xyz * in_v.tangent.xxx) + u_xlat1.xyz);
          u_xlat1.xyz = ((conv_mxt4x4_2(unity_ObjectToWorld).xyz * in_v.tangent.zzz) + u_xlat1.xyz);
          u_xlat1.xyz = normalize(u_xlat1.xyz);
          out_v.texcoord3.xyz = u_xlat1.xyz;
          u_xlat2.xyz = (u_xlat0.zxy * u_xlat1.yzx);
          u_xlat0.xyz = ((u_xlat0.yzx * u_xlat1.zxy) + (-u_xlat2.xyz));
          u_xlat0.xyz = (u_xlat0.xyz * in_v.tangent.www);
          out_v.texcoord4.xyz = normalize(u_xlat0.xyz);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float3 u_xlat16_0;
      float4 u_xlat1_d;
      float4 u_xlat16_1;
      float4 u_xlat2_d;
      float3 u_xlat16_2;
      int u_xlatb2;
      float3 u_xlat3;
      float4 u_xlat4;
      float3 u_xlat16_4;
      float3 u_xlat16_5;
      float3 u_xlat6;
      float3 u_xlat16_6;
      float4 u_xlat7;
      float3 u_xlat16_7;
      float3 u_xlat8;
      float3 u_xlat9_d;
      float3 u_xlat16_10;
      float3 u_xlat13;
      float u_xlat16_13;
      float3 u_xlat17;
      float2 u_xlat23;
      float u_xlat24;
      float u_xlat33;
      float u_xlat16_33;
      float u_xlat34;
      int u_xlatb34;
      float u_xlat35;
      float u_xlat16_35;
      float u_xlat36;
      int u_xlatb36;
      float u_xlat39;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = TRANSFORM_TEX(in_f.texcoord.xy, _MainTex);
          u_xlat16_0.xyz = tex2D(_MainTex, u_xlat0_d.xy).xyz;
          u_xlat1_d.xy = TRANSFORM_TEX(in_f.texcoord.xy, _1st_ShadeMap);
          u_xlat16_1.xyz = tex2D(_1st_ShadeMap, u_xlat1_d.xy).xyz;
          u_xlat2_d.xyz = (u_xlat16_0.xyz + (-u_xlat16_1.xyz));
          u_xlat0_d.xyz = (u_xlat16_0.xyz * _BaseColor.xyz);
          u_xlat1_d.xyz = ((float3(_Use_BaseAs1st, _Use_BaseAs1st, _Use_BaseAs1st) * u_xlat2_d.xyz) + u_xlat16_1.xyz);
          u_xlat2_d.xy = TRANSFORM_TEX(in_f.texcoord.xy, _2nd_ShadeMap);
          u_xlat16_2.xyz = tex2D(_2nd_ShadeMap, u_xlat2_d.xy).xyz;
          u_xlat3.xyz = (u_xlat1_d.xyz + (-u_xlat16_2.xyz));
          u_xlat1_d.xyz = (u_xlat1_d.xyz * _1st_ShadeColor.xyz);
          u_xlat2_d.xyz = ((float3(float3(_Use_1stAs2nd, _Use_1stAs2nd, _Use_1stAs2nd)) * u_xlat3.xyz) + u_xlat16_2.xyz);
          u_xlat2_d.xyz = (u_xlat2_d.xyz * _2nd_ShadeColor.xyz);
          u_xlat16_4.x = dot(unity_SHAr.yw, float2(-1, 1));
          u_xlat16_4.y = dot(unity_SHAg.yw, float2(-1, 1));
          u_xlat16_4.z = dot(unity_SHAb.yw, float2(-1, 1));
          u_xlat16_4.xyz = (u_xlat16_4.xyz + (-unity_SHC.xyz));
          u_xlat16_5.x = unity_SHAr.w;
          u_xlat16_5.y = unity_SHAg.w;
          u_xlat16_5.z = unity_SHAb.w;
          u_xlat16_4.xyz = max(u_xlat16_4.xyz, u_xlat16_5.xyz);
          u_xlat3.xyz = (u_xlat16_4.xyz * float3(_Unlit_Intensity, _Unlit_Intensity, _Unlit_Intensity));
          u_xlat33 = (_Unlit_Intensity * 0.0500000007);
          u_xlat3.xyz = max(u_xlat3.xyz, float3(u_xlat33, u_xlat33, u_xlat33));
          #ifdef UNITY_ADRENO_ES3
          u_xlat3.xyz = min(max(u_xlat3.xyz, 0), 1);
          #else
          u_xlat3.xyz = clamp(u_xlat3.xyz, 0, 1);
          #endif
          u_xlat16_4.xyz = _LightColor0.xyz;
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0), 1);
          #else
          u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0, 1);
          #endif
          u_xlat6.xyz = max(u_xlat3.xyz, u_xlat16_4.xyz);
          u_xlat3.xyz = max(u_xlat3.xyz, _LightColor0.xyz);
          u_xlat6.xyz = ((-u_xlat3.xyz) + u_xlat6.xyz);
          u_xlat3.xyz = ((float3(float3(_Is_Filter_LightColor, _Is_Filter_LightColor, _Is_Filter_LightColor)) * u_xlat6.xyz) + u_xlat3.xyz);
          u_xlat6.xyz = ((u_xlat2_d.xyz * u_xlat3.xyz) + (-u_xlat2_d.xyz));
          u_xlat2_d.xyz = ((float3(_Is_LightColor_2nd_Shade, _Is_LightColor_2nd_Shade, _Is_LightColor_2nd_Shade) * u_xlat6.xyz) + u_xlat2_d.xyz);
          u_xlat6.xyz = ((u_xlat1_d.xyz * u_xlat3.xyz) + (-u_xlat1_d.xyz));
          u_xlat1_d.xyz = ((float3(_Is_LightColor_1st_Shade, _Is_LightColor_1st_Shade, _Is_LightColor_1st_Shade) * u_xlat6.xyz) + u_xlat1_d.xyz);
          u_xlat2_d.xyz = ((-u_xlat1_d.xyz) + u_xlat2_d.xyz);
          u_xlat6.xy = TRANSFORM_TEX(in_f.texcoord.xy, _Set_2nd_ShadePosition);
          u_xlat16_33 = tex2D(_Set_2nd_ShadePosition, u_xlat6.xy).x;
          u_xlat16_4.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb34 = (u_xlat16_4.x!=0);
          #else
          u_xlatb34 = (u_xlat16_4.x!=0);
          #endif
          u_xlat34 = (u_xlatb34)?(1):(float(0));
          u_xlat6.x = conv_mxt4x4_0(unity_MatrixV).z;
          u_xlat6.y = conv_mxt4x4_1(unity_MatrixV).z;
          u_xlat6.z = conv_mxt4x4_2(unity_MatrixV).z;
          u_xlat7.x = conv_mxt4x4_0(unity_MatrixV).y;
          u_xlat7.y = conv_mxt4x4_1(unity_MatrixV).y;
          u_xlat7.z = conv_mxt4x4_2(unity_MatrixV).y;
          u_xlat6.xyz = (u_xlat6.xyz + u_xlat7.xyz);
          u_xlat35 = dot(u_xlat6.xyz, u_xlat6.xyz);
          u_xlat35 = rsqrt(u_xlat35);
          u_xlat7.xyz = (float3(u_xlat35, u_xlat35, u_xlat35) * u_xlat6.xyz);
          u_xlat6.xyz = (((-u_xlat6.xyz) * float3(u_xlat35, u_xlat35, u_xlat35)) + _WorldSpaceLightPos0.xyz);
          u_xlat6.xyz = ((float3(u_xlat34, u_xlat34, u_xlat34) * u_xlat6.xyz) + u_xlat7.xyz);
          u_xlat6.xyz = normalize(u_xlat6.xyz);
          u_xlat4 = (float4(_Offset_X_Axis_BLD, _Offset_X_Axis_BLD, _Offset_Y_Axis_BLD, _Offset_Y_Axis_BLD) * float4(10, 0, 0, 10));
          u_xlat7.xyz = (u_xlat4.zwz + u_xlat4.xyy);
          u_xlat16_5.x = ((_Inverse_Z_Axis_BLD * 2) + (-1));
          u_xlat7.xyz = ((u_xlat16_5.xxx * float3(0, 0, (-1))) + u_xlat7.xyz);
          u_xlat8.xyz = (u_xlat7.yyy * conv_mxt4x4_1(unity_ObjectToWorld).xyz);
          u_xlat7.xyw = ((conv_mxt4x4_0(unity_ObjectToWorld).xyz * u_xlat7.xxx) + u_xlat8.xyz);
          u_xlat7.xyz = ((conv_mxt4x4_2(unity_ObjectToWorld).xyz * u_xlat7.zzz) + u_xlat7.xyw);
          u_xlat34 = dot(u_xlat7.xyz, u_xlat7.xyz);
          u_xlat34 = rsqrt(u_xlat34);
          u_xlat7.xyz = ((u_xlat7.xyz * float3(u_xlat34, u_xlat34, u_xlat34)) + (-u_xlat6.xyz));
          u_xlat6.xyz = ((float3(_Is_BLD, _Is_BLD, _Is_BLD) * u_xlat7.xyz) + u_xlat6.xyz);
          u_xlat7.xy = TRANSFORM_TEX(in_f.texcoord.xy, _NormalMap);
          u_xlat16_7.xyz = tex2D(_NormalMap, u_xlat7.xy).xyz;
          u_xlat16_5.xyz = ((u_xlat16_7.xyz * float3(2, 2, 2)) + float3(-1, (-1), (-1)));
          u_xlat7.xyz = (u_xlat16_5.yyy * in_f.texcoord4.xyz);
          u_xlat7.xyz = ((u_xlat16_5.xxx * in_f.texcoord3.xyz) + u_xlat7.xyz);
          u_xlat8.xyz = normalize(in_f.texcoord2.xyz);
          u_xlat7.xyz = ((u_xlat16_5.zzz * u_xlat8.xyz) + u_xlat7.xyz);
          u_xlat35 = dot(u_xlat7.xyz, u_xlat7.xyz);
          u_xlat35 = rsqrt(u_xlat35);
          u_xlat9_d.xyz = ((u_xlat7.xyz * float3(u_xlat35, u_xlat35, u_xlat35)) + (-u_xlat8.xyz));
          u_xlat4.xyz = (float3(u_xlat35, u_xlat35, u_xlat35) * u_xlat7.xyz);
          u_xlat7.xyz = ((float3(_Is_NormalMapToBase, _Is_NormalMapToBase, _Is_NormalMapToBase) * u_xlat9_d.xyz) + u_xlat8.xyz);
          u_xlat35 = dot(u_xlat7.xyz, u_xlat6.xyz);
          u_xlat35 = ((u_xlat35 * 0.5) + 0.5);
          u_xlat36 = ((-_1st2nd_Shades_Feather) + _ShadeColor_Step);
          u_xlat39 = (u_xlat35 + (-u_xlat36));
          u_xlat36 = ((-u_xlat36) + _ShadeColor_Step);
          u_xlat33 = ((-u_xlat16_33) * u_xlat39);
          u_xlat33 = (u_xlat33 / u_xlat36);
          u_xlat33 = (u_xlat33 + 1);
          #ifdef UNITY_ADRENO_ES3
          u_xlat33 = min(max(u_xlat33, 0), 1);
          #else
          u_xlat33 = clamp(u_xlat33, 0, 1);
          #endif
          u_xlat1_d.xyz = ((float3(u_xlat33, u_xlat33, u_xlat33) * u_xlat2_d.xyz) + u_xlat1_d.xyz);
          u_xlat2_d.xyz = ((u_xlat0_d.xyz * u_xlat3.xyz) + (-u_xlat0_d.xyz));
          u_xlat0_d.xyz = ((float3(float3(_Is_LightColor_Base, _Is_LightColor_Base, _Is_LightColor_Base)) * u_xlat2_d.xyz) + u_xlat0_d.xyz);
          u_xlat1_d.xyz = ((-u_xlat0_d.xyz) + u_xlat1_d.xyz);
          u_xlat33 = (_Tweak_SystemShadowsLevel + 1);
          #ifdef UNITY_ADRENO_ES3
          u_xlat33 = min(max(u_xlat33, 0), 1);
          #else
          u_xlat33 = clamp(u_xlat33, 0, 1);
          #endif
          u_xlat33 = ((u_xlat35 * u_xlat33) + (-u_xlat35));
          u_xlat33 = ((_Set_SystemShadowsToBase * u_xlat33) + u_xlat35);
          u_xlat2_d.x = ((-_BaseShade_Feather) + _BaseColor_Step);
          u_xlat33 = (u_xlat33 + (-u_xlat2_d.x));
          u_xlat2_d.x = ((-u_xlat2_d.x) + _BaseColor_Step);
          u_xlat13.xy = TRANSFORM_TEX(in_f.texcoord.xy, _Set_1st_ShadePosition);
          u_xlat16_13 = tex2D(_Set_1st_ShadePosition, u_xlat13.xy).x;
          u_xlat33 = (u_xlat33 * (-u_xlat16_13));
          u_xlat33 = (u_xlat33 / u_xlat2_d.x);
          u_xlat33 = (u_xlat33 + 1);
          #ifdef UNITY_ADRENO_ES3
          u_xlat33 = min(max(u_xlat33, 0), 1);
          #else
          u_xlat33 = clamp(u_xlat33, 0, 1);
          #endif
          u_xlat0_d.xyz = ((float3(u_xlat33, u_xlat33, u_xlat33) * u_xlat1_d.xyz) + u_xlat0_d.xyz);
          u_xlat1_d.xyz = ((-in_f.texcoord1.xyz) + _WorldSpaceCameraPos.xyz);
          u_xlat2_d.x = dot(u_xlat1_d.xyz, u_xlat1_d.xyz);
          u_xlat2_d.x = rsqrt(u_xlat2_d.x);
          u_xlat13.xyz = ((u_xlat1_d.xyz * u_xlat2_d.xxx) + u_xlat6.xyz);
          u_xlat36 = dot(u_xlat8.xyz, u_xlat6.xyz);
          u_xlat36 = ((u_xlat36 * 0.5) + 0.5);
          u_xlat1_d.xyz = (u_xlat1_d.xyz * u_xlat2_d.xxx);
          u_xlat2_d.x = dot(u_xlat13.xyz, u_xlat13.xyz);
          u_xlat2_d.x = rsqrt(u_xlat2_d.x);
          u_xlat2_d.xyz = (u_xlat2_d.xxx * u_xlat13.xyz);
          u_xlat6.xyz = ((float3(float3(_Is_NormalMapToHighColor, _Is_NormalMapToHighColor, _Is_NormalMapToHighColor)) * u_xlat9_d.xyz) + u_xlat8.xyz);
          u_xlat7.xyz = ((float3(float3(_Is_NormalMapToRimLight, _Is_NormalMapToRimLight, _Is_NormalMapToRimLight)) * u_xlat9_d.xyz) + u_xlat8.xyz);
          u_xlat35 = dot(u_xlat7.xyz, u_xlat1_d.xyz);
          u_xlat35 = ((-u_xlat35) + 1);
          u_xlat35 = log2(u_xlat35);
          u_xlat2_d.x = dot(u_xlat2_d.xyz, u_xlat6.xyz);
          u_xlat2_d.x = ((u_xlat2_d.x * 0.5) + 0.5);
          u_xlat13.x = log2(u_xlat2_d.x);
          u_xlat24 = ((_HighColor_Power * (-10)) + 11);
          u_xlat24 = exp2(u_xlat24);
          u_xlat13.x = (u_xlat13.x * u_xlat24);
          u_xlat13.x = exp2(u_xlat13.x);
          u_xlat24 = (_HighColor_Power * _HighColor_Power);
          u_xlat24 = (u_xlat24 * u_xlat24);
          u_xlat24 = (((-_HighColor_Power) * u_xlat24) + 1);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb2 = (u_xlat24>=u_xlat2_d.x);
          #else
          u_xlatb2 = (u_xlat24>=u_xlat2_d.x);
          #endif
          u_xlat2_d.xz = (int(u_xlatb2))?(float2(0, (-0))):(float2(1, (-1)));
          u_xlat13.x = (u_xlat2_d.z + u_xlat13.x);
          u_xlat2_d.x = ((_Is_SpecularToHighColor * u_xlat13.x) + u_xlat2_d.x);
          u_xlat13.xy = TRANSFORM_TEX(in_f.texcoord.xy, _Set_HighColorMask);
          u_xlat16_13 = tex2D(_Set_HighColorMask, u_xlat13.xy).y;
          u_xlat13.x = (u_xlat16_13 + _Tweak_HighColorMaskLevel);
          #ifdef UNITY_ADRENO_ES3
          u_xlat13.x = min(max(u_xlat13.x, 0), 1);
          #else
          u_xlat13.x = clamp(u_xlat13.x, 0, 1);
          #endif
          u_xlat6.xyz = (((-u_xlat13.xxx) * u_xlat2_d.xxx) + u_xlat0_d.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat6.xyz = min(max(u_xlat6.xyz, 0), 1);
          #else
          u_xlat6.xyz = clamp(u_xlat6.xyz, 0, 1);
          #endif
          u_xlat0_d.xyz = (u_xlat0_d.xyz + (-u_xlat6.xyz));
          u_xlat2_d.x = (u_xlat2_d.x * u_xlat13.x);
          u_xlat16_5.x = ((-_Is_BlendAddToHiColor) + 1);
          u_xlat16_5.x = ((_Is_SpecularToHighColor * u_xlat16_5.x) + _Is_BlendAddToHiColor);
          u_xlat0_d.xyz = ((u_xlat16_5.xxx * u_xlat0_d.xyz) + u_xlat6.xyz);
          u_xlat13.xy = TRANSFORM_TEX(in_f.texcoord.xy, _HighColor_Tex);
          u_xlat16_6.xyz = tex2D(_HighColor_Tex, u_xlat13.xy).xyz;
          u_xlat6.xyz = (u_xlat16_6.xyz * _HighColor.xyz);
          u_xlat7.xyz = ((u_xlat6.xyz * u_xlat3.xyz) + (-u_xlat6.xyz));
          u_xlat6.xyz = ((float3(_Is_LightColor_HighColor, _Is_LightColor_HighColor, _Is_LightColor_HighColor) * u_xlat7.xyz) + u_xlat6.xyz);
          u_xlat2_d.xyz = (u_xlat2_d.xxx * u_xlat6.xyz);
          u_xlat6.x = ((-u_xlat33) + 1);
          u_xlat17.x = ((u_xlat33 * _TweakHighColorOnShadow) + u_xlat6.x);
          u_xlat33 = ((u_xlat33 * _TweakMatCapOnShadow) + u_xlat6.x);
          u_xlat6.xyz = ((u_xlat2_d.xyz * u_xlat17.xxx) + (-u_xlat2_d.xyz));
          u_xlat2_d.xyz = ((float3(float3(_Is_UseTweakHighColorOnShadow, _Is_UseTweakHighColorOnShadow, _Is_UseTweakHighColorOnShadow)) * u_xlat6.xyz) + u_xlat2_d.xyz);
          u_xlat0_d.xyz = (u_xlat0_d.xyz + u_xlat2_d.xyz);
          u_xlat2_d.x = ((-u_xlat36) + _Tweak_LightDirection_MaskLevel);
          u_xlat36 = u_xlat36;
          #ifdef UNITY_ADRENO_ES3
          u_xlat36 = min(max(u_xlat36, 0), 1);
          #else
          u_xlat36 = clamp(u_xlat36, 0, 1);
          #endif
          u_xlat13.x = (u_xlat36 + _Tweak_LightDirection_MaskLevel);
          u_xlat2_d.x = (u_xlat2_d.x + 1);
          u_xlat24 = ((_RimLight_Power * (-3)) + 3);
          u_xlat24 = exp2(u_xlat24);
          u_xlat24 = (u_xlat35 * u_xlat24);
          u_xlat24 = exp2(u_xlat24);
          #ifdef UNITY_ADRENO_ES3
          u_xlatb36 = (u_xlat24>=_RimLight_InsideMask);
          #else
          u_xlatb36 = (u_xlat24>=_RimLight_InsideMask);
          #endif
          u_xlat24 = (u_xlat24 + (-_RimLight_InsideMask));
          u_xlat36 = (u_xlatb36)?(1):(float(0));
          u_xlat6.x = ((-_RimLight_InsideMask) + 1);
          u_xlat24 = (u_xlat24 / u_xlat6.x);
          u_xlat36 = ((-u_xlat24) + u_xlat36);
          u_xlat24 = ((_RimLight_FeatherOff * u_xlat36) + u_xlat24);
          #ifdef UNITY_ADRENO_ES3
          u_xlat24 = min(max(u_xlat24, 0), 1);
          #else
          u_xlat24 = clamp(u_xlat24, 0, 1);
          #endif
          u_xlat2_d.x = ((-u_xlat2_d.x) + u_xlat24);
          #ifdef UNITY_ADRENO_ES3
          u_xlat2_d.x = min(max(u_xlat2_d.x, 0), 1);
          #else
          u_xlat2_d.x = clamp(u_xlat2_d.x, 0, 1);
          #endif
          u_xlat17.xyz = ((_RimLightColor.xyz * u_xlat3.xyz) + (-_RimLightColor.xyz));
          u_xlat17.xyz = ((float3(_Is_LightColor_RimLight, _Is_LightColor_RimLight, _Is_LightColor_RimLight) * u_xlat17.xyz) + _RimLightColor.xyz);
          u_xlat7.xyz = (float3(u_xlat24, u_xlat24, u_xlat24) * u_xlat17.xyz);
          u_xlat17.xyz = ((u_xlat17.xyz * u_xlat2_d.xxx) + (-u_xlat7.xyz));
          u_xlat17.xyz = ((float3(float3(_LightDirection_MaskOn, _LightDirection_MaskOn, _LightDirection_MaskOn)) * u_xlat17.xyz) + u_xlat7.xyz);
          u_xlat7.xyz = ((_Ap_RimLightColor.xyz * u_xlat3.xyz) + (-_Ap_RimLightColor.xyz));
          u_xlat7.xyz = ((float3(_Is_LightColor_Ap_RimLight, _Is_LightColor_Ap_RimLight, _Is_LightColor_Ap_RimLight) * u_xlat7.xyz) + _Ap_RimLightColor.xyz);
          u_xlat2_d.x = ((_Ap_RimLight_Power * (-3)) + 3);
          u_xlat2_d.x = exp2(u_xlat2_d.x);
          u_xlat2_d.x = (u_xlat35 * u_xlat2_d.x);
          u_xlat2_d.x = exp2(u_xlat2_d.x);
          u_xlat24 = (u_xlat2_d.x + (-_RimLight_InsideMask));
          #ifdef UNITY_ADRENO_ES3
          u_xlatb2 = (u_xlat2_d.x>=_RimLight_InsideMask);
          #else
          u_xlatb2 = (u_xlat2_d.x>=_RimLight_InsideMask);
          #endif
          u_xlat2_d.x = (u_xlatb2)?(1):(float(0));
          u_xlat24 = (u_xlat24 / u_xlat6.x);
          u_xlat2_d.x = ((-u_xlat24) + u_xlat2_d.x);
          u_xlat2_d.x = ((_Ap_RimLight_FeatherOff * u_xlat2_d.x) + u_xlat24);
          u_xlat2_d.x = ((-u_xlat13.x) + u_xlat2_d.x);
          #ifdef UNITY_ADRENO_ES3
          u_xlat2_d.x = min(max(u_xlat2_d.x, 0), 1);
          #else
          u_xlat2_d.x = clamp(u_xlat2_d.x, 0, 1);
          #endif
          u_xlat2_d.xyz = (u_xlat2_d.xxx * u_xlat7.xyz);
          u_xlat2_d.xyz = ((float3(_Add_Antipodean_RimLight, _Add_Antipodean_RimLight, _Add_Antipodean_RimLight) * u_xlat2_d.xyz) + u_xlat17.xyz);
          u_xlat6.xy = TRANSFORM_TEX(in_f.texcoord.xy, _Set_RimLightMask);
          u_xlat16_35 = tex2D(_Set_RimLightMask, u_xlat6.xy).y;
          u_xlat35 = (u_xlat16_35 + _Tweak_RimLightMaskLevel);
          #ifdef UNITY_ADRENO_ES3
          u_xlat35 = min(max(u_xlat35, 0), 1);
          #else
          u_xlat35 = clamp(u_xlat35, 0, 1);
          #endif
          u_xlat2_d.xyz = (u_xlat2_d.xyz * float3(u_xlat35, u_xlat35, u_xlat35));
          u_xlat0_d.xyz = ((float3(_RimLight, _RimLight, _RimLight) * u_xlat2_d.xyz) + u_xlat0_d.xyz);
          u_xlat2_d.x = (_Rotate_NormalMapForMatCapUV * 3.14159274);
          u_xlat6.x = cos(u_xlat2_d.x);
          u_xlat2_d.x = sin(u_xlat2_d.x);
          u_xlat7.z = u_xlat2_d.x;
          u_xlat13.xy = (in_f.texcoord.xy + float2(-0.5, (-0.5)));
          u_xlat7.y = u_xlat6.x;
          u_xlat7.x = (-u_xlat2_d.x);
          u_xlat6.y = dot(u_xlat13.xy, u_xlat7.xy);
          u_xlat6.x = dot(u_xlat13.xy, u_xlat7.yz);
          u_xlat2_d.xy = (u_xlat6.xy + float2(0.5, 0.5));
          u_xlat2_d.xy = TRANSFORM_TEX(u_xlat2_d.xy, _NormalMapForMatCap);
          u_xlat16_2.xyz = tex2D(_NormalMapForMatCap, u_xlat2_d.xy).xyz;
          u_xlat16_5.xyz = ((u_xlat16_2.xyz * float3(2, 2, 2)) + float3(-1, (-1), (-1)));
          u_xlat2_d.xyz = (u_xlat16_5.yyy * in_f.texcoord4.xyz);
          u_xlat2_d.xyz = ((u_xlat16_5.xxx * in_f.texcoord3.xyz) + u_xlat2_d.xyz);
          u_xlat2_d.xyz = ((u_xlat16_5.zzz * u_xlat8.xyz) + u_xlat2_d.xyz);
          u_xlat2_d.xyz = (((-in_f.texcoord2.xyz) * float3(u_xlat34, u_xlat34, u_xlat34)) + u_xlat2_d.xyz);
          u_xlat2_d.xyz = ((float3(_Is_NormalMapForMatCap, _Is_NormalMapForMatCap, _Is_NormalMapForMatCap) * u_xlat2_d.xyz) + u_xlat8.xyz);
          u_xlat6.xyz = (u_xlat2_d.yyy * conv_mxt4x4_1(unity_MatrixV).xyz);
          u_xlat2_d.xyw = ((conv_mxt4x4_0(unity_MatrixV).xyz * u_xlat2_d.xxx) + u_xlat6.xyz);
          u_xlat2_d.xyz = ((conv_mxt4x4_2(unity_MatrixV).xyz * u_xlat2_d.zzz) + u_xlat2_d.xyw);
          u_xlat6.xyz = (u_xlat2_d.xyz * float3(-1, (-1), 1));
          u_xlat7.xyz = (u_xlat1_d.yyy * conv_mxt4x4_1(unity_MatrixV).xyz);
          u_xlat1_d.xyw = ((conv_mxt4x4_0(unity_MatrixV).xyz * u_xlat1_d.xxx) + u_xlat7.xyz);
          u_xlat1_d.xyz = ((conv_mxt4x4_2(unity_MatrixV).xyz * u_xlat1_d.zzz) + u_xlat1_d.xyw);
          u_xlat1_d.xyz = ((u_xlat1_d.xyz * float3(-1, (-1), 1)) + float3(0, 0, 1));
          u_xlat34 = dot(u_xlat1_d.xyz, u_xlat6.xyz);
          u_xlat1_d.xy = (float2(u_xlat34, u_xlat34) * u_xlat1_d.xy);
          u_xlat1_d.xy = (u_xlat1_d.xy / u_xlat1_d.zz);
          u_xlat1_d.xy = (((-u_xlat2_d.xy) * float2(-1, (-1))) + u_xlat1_d.xy);
          u_xlat23.xy = ((-u_xlat1_d.xy) + u_xlat2_d.xy);
          u_xlat1_d.xy = ((float2(_Is_Ortho, _Is_Ortho) * u_xlat23.xy) + u_xlat1_d.xy);
          u_xlat1_d.xy = ((u_xlat1_d.xy * float2(0.5, 0.5)) + float2(0.5, 0.5));
          u_xlat1_d.xy = (u_xlat1_d.xy + (-float2(_Tweak_MatCapUV, _Tweak_MatCapUV)));
          u_xlat23.x = ((_Tweak_MatCapUV * (-2)) + 1);
          u_xlat1_d.xy = (u_xlat1_d.xy / u_xlat23.xx);
          u_xlat1_d.xy = (u_xlat1_d.xy + float2(-0.5, (-0.5)));
          u_xlat23.x = (_Rotate_MatCapUV * 3.14159274);
          u_xlat2_d.x = sin(u_xlat23.x);
          u_xlat6.x = cos(u_xlat23.x);
          u_xlat7.z = u_xlat2_d.x;
          u_xlat7.y = u_xlat6.x;
          u_xlat7.x = (-u_xlat2_d.x);
          u_xlat2_d.y = dot(u_xlat1_d.xy, u_xlat7.xy);
          u_xlat2_d.x = dot(u_xlat1_d.xy, u_xlat7.yz);
          u_xlat1_d.xy = (u_xlat2_d.xy + float2(0.5, 0.5));
          u_xlat1_d.xy = TRANSFORM_TEX(u_xlat1_d.xy, _MatCap_Sampler);
          u_xlat16_1.xyz = tex2D(_MatCap_Sampler, u_xlat1_d.xy).xyz;
          u_xlat1_d.xyz = (u_xlat16_1.xyz * _MatCapColor.xyz);
          u_xlat2_d.xyz = ((u_xlat1_d.xyz * u_xlat3.xyz) + (-u_xlat1_d.xyz));
          u_xlat1_d.xyz = ((float3(_Is_LightColor_MatCap, _Is_LightColor_MatCap, _Is_LightColor_MatCap) * u_xlat2_d.xyz) + u_xlat1_d.xyz);
          u_xlat2_d.xyz = ((u_xlat1_d.xyz * float3(u_xlat33, u_xlat33, u_xlat33)) + (-u_xlat1_d.xyz));
          u_xlat1_d.xyz = ((float3(_Is_UseTweakMatCapOnShadow, _Is_UseTweakMatCapOnShadow, _Is_UseTweakMatCapOnShadow) * u_xlat2_d.xyz) + u_xlat1_d.xyz);
          u_xlat2_d.xyz = (u_xlat0_d.xyz * u_xlat1_d.xyz);
          u_xlat3.xy = TRANSFORM_TEX(in_f.texcoord.xy, _Set_MatcapMask);
          u_xlat16_33 = tex2D(_Set_MatcapMask, u_xlat3.xy).y;
          u_xlat33 = (u_xlat16_33 + _Tweak_MatcapMaskLevel);
          #ifdef UNITY_ADRENO_ES3
          u_xlat33 = min(max(u_xlat33, 0), 1);
          #else
          u_xlat33 = clamp(u_xlat33, 0, 1);
          #endif
          u_xlat2_d.xyz = (float3(u_xlat33, u_xlat33, u_xlat33) * u_xlat2_d.xyz);
          u_xlat34 = ((-u_xlat33) + 1);
          u_xlat1_d.xyz = ((u_xlat1_d.xyz * float3(u_xlat33, u_xlat33, u_xlat33)) + u_xlat0_d.xyz);
          u_xlat2_d.xyz = ((u_xlat0_d.xyz * float3(u_xlat34, u_xlat34, u_xlat34)) + u_xlat2_d.xyz);
          u_xlat1_d.xyz = (u_xlat1_d.xyz + (-u_xlat2_d.xyz));
          u_xlat1_d.xyz = ((float3(float3(_Is_BlendAddToMatCap, _Is_BlendAddToMatCap, _Is_BlendAddToMatCap)) * u_xlat1_d.xyz) + u_xlat2_d.xyz);
          u_xlat1_d.xyz = ((-u_xlat0_d.xyz) + u_xlat1_d.xyz);
          u_xlat0_d.xyz = ((float3(_MatCap, _MatCap, _MatCap) * u_xlat1_d.xyz) + u_xlat0_d.xyz);
          u_xlat16_5.x = (u_xlat4.y * u_xlat4.y);
          u_xlat16_5.x = ((u_xlat4.x * u_xlat4.x) + (-u_xlat16_5.x));
          u_xlat16_1 = (u_xlat4.yzzx * u_xlat4.xyzz);
          u_xlat16_10.x = dot(unity_SHBr, u_xlat16_1);
          u_xlat16_10.y = dot(unity_SHBg, u_xlat16_1);
          u_xlat16_10.z = dot(unity_SHBb, u_xlat16_1);
          u_xlat16_5.xyz = ((unity_SHC.xyz * u_xlat16_5.xxx) + u_xlat16_10.xyz);
          u_xlat4.w = 1;
          u_xlat16_10.x = dot(unity_SHAr, u_xlat4);
          u_xlat16_10.y = dot(unity_SHAg, u_xlat4);
          u_xlat16_10.z = dot(unity_SHAb, u_xlat4);
          u_xlat16_5.xyz = (u_xlat16_5.xyz + u_xlat16_10.xyz);
          u_xlat0_d.xyz = ((u_xlat16_5.xyz * float3(_GI_Intensity, _GI_Intensity, _GI_Intensity)) + u_xlat0_d.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat0_d.xyz = min(max(u_xlat0_d.xyz, 0), 1);
          #else
          u_xlat0_d.xyz = clamp(u_xlat0_d.xyz, 0, 1);
          #endif
          u_xlat2_d.xy = TRANSFORM_TEX(in_f.texcoord.xy, _Emissive_Tex);
          u_xlat16_2.xyz = tex2D(_Emissive_Tex, u_xlat2_d.xy).xyz;
          out_f.SV_TARGET0.xyz = ((u_xlat16_2.xyz * _Emissive_Color.xyz) + u_xlat0_d.xyz);
          out_f.SV_TARGET0.w = 1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: FORWARD_DELTA
    {
      Name "FORWARD_DELTA"
      Tags
      { 
        "LIGHTMODE" = "FORWARDADD"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      Cull Off
      Blend One One
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile POINT _IS_CLIPPING_OFF _IS_PASS_FWDDELTA
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
      uniform float4x4 unity_WorldToLight;
      //uniform float4 _WorldSpaceLightPos0;
      uniform float4 _LightColor0;
      uniform float4 _MainTex_ST;
      uniform float4 _BaseColor;
      uniform float _Use_BaseAs1st;
      uniform float _Use_1stAs2nd;
      uniform float _Is_LightColor_Base;
      uniform float4 _1st_ShadeMap_ST;
      uniform float4 _1st_ShadeColor;
      uniform float _Is_LightColor_1st_Shade;
      uniform float4 _2nd_ShadeMap_ST;
      uniform float4 _2nd_ShadeColor;
      uniform float _Is_LightColor_2nd_Shade;
      uniform float4 _NormalMap_ST;
      uniform float _Is_NormalMapToBase;
      uniform float _Set_SystemShadowsToBase;
      uniform float _Tweak_SystemShadowsLevel;
      uniform float _BaseColor_Step;
      uniform float _BaseShade_Feather;
      uniform float4 _Set_1st_ShadePosition_ST;
      uniform float _ShadeColor_Step;
      uniform float _1st2nd_Shades_Feather;
      uniform float4 _Set_2nd_ShadePosition_ST;
      uniform float _Is_Filter_HiCutPointLightColor;
      uniform float _Is_Filter_LightColor;
      uniform float _ColorBoost;
      uniform float _StepOffset;
      uniform sampler2D _NormalMap;
      uniform sampler2D _MainTex;
      uniform sampler2D _LightTexture0;
      uniform sampler2D _1st_ShadeMap;
      uniform sampler2D _2nd_ShadeMap;
      uniform sampler2D _Set_2nd_ShadePosition;
      uniform sampler2D _Set_1st_ShadePosition;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 tangent :TANGENT0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
          float3 texcoord5 :TEXCOORD5;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
      };
      
      struct OUT_Data_Frag
      {
          float4 SV_TARGET0 :SV_TARGET0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float3 u_xlat3;
      float u_xlat13;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat0);
          out_v.vertex = mul(unity_MatrixVP, u_xlat1);
          out_v.texcoord.xy = in_v.texcoord.xy;
          out_v.texcoord1 = u_xlat0;
          u_xlat1.x = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat1.y = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat1.z = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat1.xyz = normalize(u_xlat1.xyz);
          out_v.texcoord2.xyz = u_xlat1.xyz;
          u_xlat2.xyz = (in_v.tangent.yyy * conv_mxt4x4_1(unity_ObjectToWorld).xyz);
          u_xlat2.xyz = ((conv_mxt4x4_0(unity_ObjectToWorld).xyz * in_v.tangent.xxx) + u_xlat2.xyz);
          u_xlat2.xyz = ((conv_mxt4x4_2(unity_ObjectToWorld).xyz * in_v.tangent.zzz) + u_xlat2.xyz);
          u_xlat2.xyz = normalize(u_xlat2.xyz);
          out_v.texcoord3.xyz = u_xlat2.xyz;
          u_xlat3.xyz = (u_xlat1.zxy * u_xlat2.yzx);
          u_xlat1.xyz = ((u_xlat1.yzx * u_xlat2.zxy) + (-u_xlat3.xyz));
          u_xlat1.xyz = (u_xlat1.xyz * in_v.tangent.www);
          out_v.texcoord4.xyz = normalize(u_xlat1.xyz);
          u_xlat1.xyz = (u_xlat0.yyy * conv_mxt4x4_1(unity_WorldToLight).xyz);
          u_xlat1.xyz = ((conv_mxt4x4_0(unity_WorldToLight).xyz * u_xlat0.xxx) + u_xlat1.xyz);
          u_xlat0.xyz = ((conv_mxt4x4_2(unity_WorldToLight).xyz * u_xlat0.zzz) + u_xlat1.xyz);
          out_v.texcoord5.xyz = ((conv_mxt4x4_3(unity_WorldToLight).xyz * u_xlat0.www) + u_xlat0.xyz);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float3 u_xlat16_0;
      float3 u_xlat16_1;
      float3 u_xlat2_d;
      float3 u_xlat3_d;
      float3 u_xlat16_3;
      float3 u_xlat16_4;
      float3 u_xlat5;
      float3 u_xlat16_5;
      float3 u_xlat6;
      float3 u_xlat16_6;
      float3 u_xlat7;
      float3 u_xlat8;
      float3 u_xlat9;
      float u_xlat16_9;
      float u_xlat16_10;
      float u_xlat18;
      float u_xlat27;
      float u_xlat16_27;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = TRANSFORM_TEX(in_f.texcoord.xy, _NormalMap);
          u_xlat16_0.xyz = tex2D(_NormalMap, u_xlat0_d.xy).xyz;
          u_xlat16_1.xyz = ((u_xlat16_0.xyz * float3(2, 2, 2)) + float3(-1, (-1), (-1)));
          u_xlat0_d.xyz = (u_xlat16_1.yyy * in_f.texcoord4.xyz);
          u_xlat0_d.xyz = ((u_xlat16_1.xxx * in_f.texcoord3.xyz) + u_xlat0_d.xyz);
          u_xlat2_d.xyz = normalize(in_f.texcoord2.xyz);
          u_xlat0_d.xyz = ((u_xlat16_1.zzz * u_xlat2_d.xyz) + u_xlat0_d.xyz);
          u_xlat27 = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          u_xlat27 = rsqrt(u_xlat27);
          u_xlat0_d.xyz = ((u_xlat0_d.xyz * float3(u_xlat27, u_xlat27, u_xlat27)) + (-u_xlat2_d.xyz));
          u_xlat0_d.xyz = ((float3(_Is_NormalMapToBase, _Is_NormalMapToBase, _Is_NormalMapToBase) * u_xlat0_d.xyz) + u_xlat2_d.xyz);
          u_xlat2_d.xyz = ((_WorldSpaceLightPos0.www * (-in_f.texcoord1.xyz)) + _WorldSpaceLightPos0.xyz);
          u_xlat2_d.xyz = normalize(u_xlat2_d.xyz);
          u_xlat0_d.x = dot(u_xlat0_d.xyz, u_xlat2_d.xyz);
          u_xlat0_d.x = ((u_xlat0_d.x * 0.5) + 0.5);
          u_xlat9.x = (_ShadeColor_Step + _StepOffset);
          #ifdef UNITY_ADRENO_ES3
          u_xlat9.x = min(max(u_xlat9.x, 0), 1);
          #else
          u_xlat9.x = clamp(u_xlat9.x, 0, 1);
          #endif
          u_xlat18 = (u_xlat9.x + (-_1st2nd_Shades_Feather));
          u_xlat9.x = ((-u_xlat18) + u_xlat9.x);
          u_xlat18 = ((-u_xlat18) + u_xlat0_d.x);
          u_xlat2_d.xy = TRANSFORM_TEX(in_f.texcoord.xy, _Set_2nd_ShadePosition);
          u_xlat16_27 = tex2D(_Set_2nd_ShadePosition, u_xlat2_d.xy).x;
          u_xlat18 = ((-u_xlat16_27) * u_xlat18);
          u_xlat9.x = (u_xlat18 / u_xlat9.x);
          u_xlat9.x = (u_xlat9.x + 1);
          #ifdef UNITY_ADRENO_ES3
          u_xlat9.x = min(max(u_xlat9.x, 0), 1);
          #else
          u_xlat9.x = clamp(u_xlat9.x, 0, 1);
          #endif
          u_xlat2_d.xyz = (u_xlat0_d.xxx * _LightColor0.xyz);
          u_xlat3_d.xyz = (in_f.texcoord1.yyy * conv_mxt4x4_1(unity_WorldToLight).xyz);
          u_xlat3_d.xyz = ((conv_mxt4x4_0(unity_WorldToLight).xyz * in_f.texcoord1.xxx) + u_xlat3_d.xyz);
          u_xlat3_d.xyz = ((conv_mxt4x4_2(unity_WorldToLight).xyz * in_f.texcoord1.zzz) + u_xlat3_d.xyz);
          u_xlat3_d.xyz = (u_xlat3_d.xyz + conv_mxt4x4_3(unity_WorldToLight).xyz);
          u_xlat18 = dot(u_xlat3_d.xyz, u_xlat3_d.xyz);
          u_xlat18 = tex2D(_LightTexture0, float2(u_xlat18, u_xlat18)).x;
          u_xlat2_d.xyz = (float3(u_xlat18, u_xlat18, u_xlat18) * u_xlat2_d.xyz);
          u_xlat16_1.x = dot(_LightColor0.xyz, float3(0.298999995, 0.587000012, 0.114));
          u_xlat16_10 = max(u_xlat16_1.x, 0.00100000005);
          u_xlat16_1.x = (u_xlat18 * u_xlat16_1.x);
          u_xlat16_4.xyz = (float3(u_xlat18, u_xlat18, u_xlat18) * _LightColor0.xyz);
          u_xlat18 = (u_xlat16_1.x * _WorldSpaceLightPos0.w);
          u_xlat3_d.xyz = (u_xlat2_d.xyz / float3(u_xlat16_10, u_xlat16_10, u_xlat16_10));
          u_xlat3_d.xyz = (u_xlat3_d.xyz * _WorldSpaceLightPos0.www);
          u_xlat3_d.xyz = ((u_xlat3_d.xyz * float3(_ColorBoost, _ColorBoost, _ColorBoost)) + (-u_xlat2_d.xyz));
          u_xlat2_d.xyz = ((float3(float3(_Is_Filter_LightColor, _Is_Filter_LightColor, _Is_Filter_LightColor)) * u_xlat3_d.xyz) + u_xlat2_d.xyz);
          u_xlat2_d.xyz = max(u_xlat2_d.xyz, float3(0, 0, 0));
          u_xlat27 = (_BaseColor_Step + _StepOffset);
          #ifdef UNITY_ADRENO_ES3
          u_xlat27 = min(max(u_xlat27, 0), 1);
          #else
          u_xlat27 = clamp(u_xlat27, 0, 1);
          #endif
          u_xlat3_d.xyz = (float3(u_xlat27, u_xlat27, u_xlat27) * u_xlat16_4.xyz);
          u_xlat3_d.xyz = min(u_xlat2_d.xyz, u_xlat3_d.xyz);
          u_xlat3_d.xyz = ((-u_xlat2_d.xyz) + u_xlat3_d.xyz);
          u_xlat3_d.xyz = (u_xlat3_d.xyz * _WorldSpaceLightPos0.www);
          u_xlat2_d.xyz = ((float3(_Is_Filter_HiCutPointLightColor, _Is_Filter_HiCutPointLightColor, _Is_Filter_HiCutPointLightColor) * u_xlat3_d.xyz) + u_xlat2_d.xyz);
          u_xlat3_d.xy = TRANSFORM_TEX(in_f.texcoord.xy, _MainTex);
          u_xlat16_3.xyz = tex2D(_MainTex, u_xlat3_d.xy).xyz;
          u_xlat5.xy = TRANSFORM_TEX(in_f.texcoord.xy, _1st_ShadeMap);
          u_xlat16_5.xyz = tex2D(_1st_ShadeMap, u_xlat5.xy).xyz;
          u_xlat6.xyz = (u_xlat16_3.xyz + (-u_xlat16_5.xyz));
          u_xlat3_d.xyz = (u_xlat16_3.xyz * _BaseColor.xyz);
          u_xlat5.xyz = ((float3(_Use_BaseAs1st, _Use_BaseAs1st, _Use_BaseAs1st) * u_xlat6.xyz) + u_xlat16_5.xyz);
          u_xlat6.xy = TRANSFORM_TEX(in_f.texcoord.xy, _2nd_ShadeMap);
          u_xlat16_6.xyz = tex2D(_2nd_ShadeMap, u_xlat6.xy).xyz;
          u_xlat7.xyz = (u_xlat5.xyz + (-u_xlat16_6.xyz));
          u_xlat5.xyz = (u_xlat5.xyz * _1st_ShadeColor.xyz);
          u_xlat6.xyz = ((float3(float3(_Use_1stAs2nd, _Use_1stAs2nd, _Use_1stAs2nd)) * u_xlat7.xyz) + u_xlat16_6.xyz);
          u_xlat6.xyz = (u_xlat6.xyz * _2nd_ShadeColor.xyz);
          u_xlat7.xyz = (float3(u_xlat18, u_xlat18, u_xlat18) * u_xlat6.xyz);
          u_xlat6.xyz = ((u_xlat6.xyz * u_xlat2_d.xyz) + (-u_xlat7.xyz));
          u_xlat6.xyz = ((float3(_Is_LightColor_2nd_Shade, _Is_LightColor_2nd_Shade, _Is_LightColor_2nd_Shade) * u_xlat6.xyz) + u_xlat7.xyz);
          u_xlat7.xyz = (float3(u_xlat18, u_xlat18, u_xlat18) * u_xlat5.xyz);
          u_xlat8.xyz = (float3(u_xlat18, u_xlat18, u_xlat18) * u_xlat3_d.xyz);
          u_xlat3_d.xyz = ((u_xlat3_d.xyz * u_xlat2_d.xyz) + (-u_xlat8.xyz));
          u_xlat3_d.xyz = ((float3(float3(_Is_LightColor_Base, _Is_LightColor_Base, _Is_LightColor_Base)) * u_xlat3_d.xyz) + u_xlat8.xyz);
          u_xlat2_d.xyz = ((u_xlat5.xyz * u_xlat2_d.xyz) + (-u_xlat7.xyz));
          u_xlat2_d.xyz = ((float3(_Is_LightColor_1st_Shade, _Is_LightColor_1st_Shade, _Is_LightColor_1st_Shade) * u_xlat2_d.xyz) + u_xlat7.xyz);
          u_xlat5.xyz = ((-u_xlat2_d.xyz) + u_xlat6.xyz);
          u_xlat2_d.xyz = ((u_xlat9.xxx * u_xlat5.xyz) + u_xlat2_d.xyz);
          u_xlat2_d.xyz = ((-u_xlat3_d.xyz) + u_xlat2_d.xyz);
          u_xlat9.x = (_Tweak_SystemShadowsLevel + 1);
          #ifdef UNITY_ADRENO_ES3
          u_xlat9.x = min(max(u_xlat9.x, 0), 1);
          #else
          u_xlat9.x = clamp(u_xlat9.x, 0, 1);
          #endif
          u_xlat9.x = ((u_xlat0_d.x * u_xlat9.x) + (-u_xlat0_d.x));
          u_xlat0_d.x = ((_Set_SystemShadowsToBase * u_xlat9.x) + u_xlat0_d.x);
          u_xlat9.x = (u_xlat27 + (-_BaseShade_Feather));
          u_xlat18 = ((-u_xlat9.x) + u_xlat27);
          u_xlat0_d.x = ((-u_xlat9.x) + u_xlat0_d.x);
          u_xlat9.xz = TRANSFORM_TEX(in_f.texcoord.xy, _Set_1st_ShadePosition);
          u_xlat16_9 = tex2D(_Set_1st_ShadePosition, u_xlat9.xz).x;
          u_xlat0_d.x = ((-u_xlat16_9) * u_xlat0_d.x);
          u_xlat0_d.x = (u_xlat0_d.x / u_xlat18);
          u_xlat0_d.x = (u_xlat0_d.x + 1);
          #ifdef UNITY_ADRENO_ES3
          u_xlat0_d.x = min(max(u_xlat0_d.x, 0), 1);
          #else
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0, 1);
          #endif
          out_f.SV_TARGET0.xyz = ((u_xlat0_d.xxx * u_xlat2_d.xyz) + u_xlat3_d.xyz);
          #ifdef UNITY_ADRENO_ES3
          out_f.SV_TARGET0.xyz = min(max(out_f.SV_TARGET0.xyz, 0), 1);
          #else
          out_f.SV_TARGET0.xyz = clamp(out_f.SV_TARGET0.xyz, 0, 1);
          #endif
          out_f.SV_TARGET0.w = 0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 4, name: ShadowCaster
    {
      Name "ShadowCaster"
      Tags
      { 
        "LIGHTMODE" = "SHADOWCASTER"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      Cull Off
      Offset 1, 1
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile SHADOWS_DEPTH _IS_CLIPPING_OFF
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
          float4 SV_TARGET0 :SV_TARGET0;
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
          out_f.SV_TARGET0 = float4(0, 0, 0, 0);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Legacy Shaders/VertexLit"
}
