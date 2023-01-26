Shader "TN/SceneEffect"
{
  Properties
  {
    [HDR] _MainColor ("MainColor", Color) = (1,1,1,1)
    [Header(NoiseTex)] [MaterialToggle] _UseNoiseTex ("UseNoiseTex", float) = 0
    _NoiseTex ("NoiseTex", 2D) = "white" {}
    _NoiseSpd_X ("NoiseSpd_X", float) = 0
    _NoiseSpd_Y ("NoiseSpd_Y", float) = 0
    _NoiseSlider ("NoiseSlider", Range(0, 1)) = 0
    [Header(MainTex)] [MaterialToggle] _UseMainTex ("UseMainTex", float) = 0
    _MainTex ("MainTex", 2D) = "white" {}
    [HDR] _TexColor ("TexColor", Color) = (1,1,1,1)
    [MaterialToggle] _Overlay ("UseOverlay", float) = 0
    [MaterialToggle] _Desaturate ("UseDesatureate", float) = 0
    [Enum(UnityEngine.Rendering.BlendMode)] _SourceBlend ("SrcBlend", float) = 0
    [Enum(UnityEngine.Rendering.BlendMode)] _DestBlend ("DestBlend", float) = 0
    [Enum(Off,0,Front,1,Back,2)] _Cull ("CullMask", float) = 0
    [Enum(Off,0,On,1)] _ZWrite ("ZWrite", float) = 1
    [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", float) = 2
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
      "IGNOREPROJECTOR" = "true"
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
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "FORWARDBASE"
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
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
      //uniform float4 _Time;
      uniform float _Desaturate;
      uniform float _Overlay;
      uniform float _NoiseSpd_X;
      uniform float _NoiseSpd_Y;
      uniform float _NoiseSlider;
      uniform float _UseNoiseTex;
      uniform float _UseMainTex;
      uniform float4 _NoiseTex_ST;
      uniform float4 _MainTex_ST;
      uniform float4 _MainColor;
      uniform float4 _TexColor;
      uniform sampler2D _NoiseTex;
      uniform sampler2D _GrabpassTex2;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
          float4 color :COLOR0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 color :COLOR0;
          float4 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float4 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
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
          out_v.vertex.z = 0;
          out_v.vertex.w = in_v.vertex.w;
          u_xlat0.xy = ((in_v.texcoord.xy * float2(2, 2)) + float2(-1, (-1)));
          out_v.vertex.xy = u_xlat0.xy;
          out_v.texcoord.xy = in_v.texcoord.xy;
          out_v.color = in_v.color;
          u_xlat1 = (u_xlat0.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * u_xlat0.xxxx) + u_xlat1);
          u_xlat0 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          u_xlat2 = (u_xlat0.y * conv_mxt4x4_1(unity_MatrixV).z);
          u_xlat0.x = ((conv_mxt4x4_0(unity_MatrixV).z * u_xlat0.x) + u_xlat2);
          u_xlat0.x = ((conv_mxt4x4_2(unity_MatrixV).z * u_xlat0.z) + u_xlat0.x);
          u_xlat0.x = ((conv_mxt4x4_3(unity_MatrixV).z * u_xlat0.w) + u_xlat0.x);
          out_v.texcoord1.z = (-u_xlat0.x);
          u_xlat0.z = in_v.vertex.w;
          u_xlat0.xy = ((in_v.texcoord.xy * float2(2, 2)) + float2(-1, (-1)));
          u_xlat0.y = (u_xlat0.y * _ProjectionParams.x);
          u_xlat0.xzw = (u_xlat0.xzy * float3(0.5, 0.5, 0.5));
          out_v.texcoord1.xy = (u_xlat0.zz + u_xlat0.xw);
          out_v.texcoord1.w = in_v.vertex.w;
          out_v.texcoord2 = in_v.texcoord1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float3 u_xlat16_0;
      float2 u_xlatb0;
      float3 u_xlat1_d;
      float3 u_xlat16_1;
      float2 u_xlatb2;
      float3 u_xlat3;
      float3 u_xlat4;
      float3 u_xlatb5;
      float u_xlat18;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlatb0.xy = bool4(float4(0, 0, 0, 0) != float4(_UseNoiseTex, _UseMainTex, _UseNoiseTex, _UseNoiseTex)).xy;
          if(u_xlatb0.x)
          {
              u_xlat0_d.xz = (_Time.yy * float2(_NoiseSpd_X, _NoiseSpd_Y));
              u_xlat0_d.xz = ((u_xlat0_d.xz * _NoiseTex_ST.xy) + in_f.texcoord1.xy);
              u_xlat0_d.xz = (u_xlat0_d.xz + _NoiseTex_ST.zw);
              u_xlat16_0.xz = tex2D(_NoiseTex, u_xlat0_d.xz).xy;
              u_xlat0_d.xz = ((u_xlat16_0.xz * float2(-2, 1)) + float2(1, 0));
              u_xlat0_d.xz = (u_xlat0_d.xz + (-in_f.texcoord1.xy));
              u_xlat0_d.xz = ((float2(_NoiseSlider, _NoiseSlider) * u_xlat0_d.xz) + in_f.texcoord1.xy);
          }
          else
          {
              u_xlat0_d.xz = in_f.texcoord1.xy;
          }
          u_xlat16_1.xyz = tex2D(_GrabpassTex2, u_xlat0_d.xz).xyz;
          u_xlatb2.xy = bool4(float4(0, 0, 0, 0) != float4(_Overlay, _Desaturate, _Overlay, _Overlay)).xy;
          u_xlat3.xyz = (_MainColor.xyz + float3(-0.5, (-0.5), (-0.5)));
          u_xlat3.xyz = (((-u_xlat3.xyz) * float3(2, 2, 2)) + float3(1, 1, 1));
          u_xlat4.xyz = ((-u_xlat16_1.xyz) + float3(1, 1, 1));
          u_xlat3.xyz = (((-u_xlat3.xyz) * u_xlat4.xyz) + float3(1, 1, 1));
          u_xlat4.xyz = (u_xlat16_1.xyz * _MainColor.xyz);
          u_xlat4.xyz = (u_xlat4.xyz + u_xlat4.xyz);
          u_xlat3.xyz = lerp(float3(0, 0, 0), u_xlat3.xyz, float3(u_xlatb2.xxx));
          u_xlat4.xyz = lerp(float3(0, 0, 0), u_xlat4.xyz, float3(u_xlatb2.xxx));
          if(u_xlatb0.y)
          {
              u_xlat0_d.xy = TRANSFORM_TEX(u_xlat0_d.xz, _MainTex);
              u_xlat16_0.xyz = tex2D(_MainTex, u_xlat0_d.xy).xyz;
              u_xlat0_d.xyz = (u_xlat16_0.xyz * in_f.color.xyz);
              u_xlat0_d.xyz = (u_xlat0_d.xyz * _TexColor.xyz);
          }
          else
          {
              u_xlat0_d.x = float(0);
              u_xlat0_d.y = float(0);
              u_xlat0_d.z = float(0);
          }
          u_xlatb5.xyz = bool4(float4(0.5, 0.5, 0.5, 0) < _MainColor.xyzx).xyz;
          float3 hlslcc_movcTemp = u_xlat3;
          hlslcc_movcTemp.x = (u_xlatb5.x)?(u_xlat3.x):(u_xlat4.x);
          hlslcc_movcTemp.y = (u_xlatb5.y)?(u_xlat3.y):(u_xlat4.y);
          hlslcc_movcTemp.z = (u_xlatb5.z)?(u_xlat3.z):(u_xlat4.z);
          u_xlat3 = hlslcc_movcTemp;
          #ifdef UNITY_ADRENO_ES3
          u_xlat3.xyz = min(max(u_xlat3.xyz, 0), 1);
          #else
          u_xlat3.xyz = clamp(u_xlat3.xyz, 0, 1);
          #endif
          u_xlat3.xyz = (u_xlat0_d.xyz + u_xlat3.xyz);
          u_xlat18 = dot(u_xlat16_1.xyz, float3(0.300000012, 0.589999974, 0.109999999));
          u_xlat4.xyz = ((-float3(u_xlat18, u_xlat18, u_xlat18)) + u_xlat16_1.xyz);
          u_xlat4.xyz = ((in_f.texcoord2.xxx * u_xlat4.xyz) + float3(u_xlat18, u_xlat18, u_xlat18));
          u_xlat4.xyz = (u_xlat0_d.xyz + u_xlat4.xyz);
          u_xlat1_d.xyz = (u_xlat16_1.xyz * in_f.color.xyz);
          u_xlat1_d.xyz = (u_xlat1_d.xyz * _MainColor.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat1_d.xyz = min(max(u_xlat1_d.xyz, 0), 1);
          #else
          u_xlat1_d.xyz = clamp(u_xlat1_d.xyz, 0, 1);
          #endif
          u_xlat0_d.xyz = (u_xlat0_d.xyz + u_xlat1_d.xyz);
          u_xlat0_d.xyz = (u_xlatb2.y)?(u_xlat4.xyz):(u_xlat0_d.xyz);
          out_f.color.xyz = (u_xlatb2.x)?(u_xlat3.xyz):(u_xlat0_d.xyz);
          out_f.color.w = in_f.color.w;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
