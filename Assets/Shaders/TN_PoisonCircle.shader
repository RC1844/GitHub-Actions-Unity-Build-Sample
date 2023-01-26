Shader "TN/PoisonCircle"
{
  Properties
  {
    [HDR] _MainColor ("MainColor", Color) = (1,1,1,1)
    [HDR] _DepthColor ("DepthColor", Color) = (1,1,1,1)
    _WaterUV ("WaterUV", Vector) = (10,10,250,3)
    _Opacity ("Opacity", Range(0, 1)) = 1
    _DepthSlider ("DepthSlider", Range(0, 10)) = 1
    _BaseColor ("BaseColor", Color) = (1,1,1,1)
    [Header(Blender Setting)] [Enum(UnityEngine.Rendering.BlendMode)] _SourceBlend ("SrcBlend", float) = 0
    [Enum(UnityEngine.Rendering.BlendMode)] _DestBlend ("DestBlend", float) = 0
    [Enum(Off,0,Front,1,Back,2)] _Cull ("CullMask", float) = 0
    [Enum(Off,0,On,1)] _ZWrite ("ZWrite", float) = 1
    [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", float) = 2
    [Header(Stencil Setting)] _Ref ("Ref", float) = 0
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
      "RenderType" = "TN_PoisonCircle"
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
        "QUEUE" = "Transparent"
        "RenderType" = "TN_PoisonCircle"
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
      //uniform float4x4 unity_MatrixVP;
      //uniform float4 _Time;
      //uniform float4 _ZBufferParams;
      uniform float4 _MainColor;
      uniform float4 _DepthColor;
      uniform float4 _BaseColor;
      uniform float4 _WaterUV;
      uniform float _Opacity;
      uniform float _DepthSlider;
      uniform float DepthTextureActive;
      uniform sampler2D _CameraDepthTexture;
      uniform sampler2D _GrabpassTex_Skill;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 color :COLOR0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 color :COLOR0;
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
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
          out_v.color = in_v.color;
          out_v.texcoord = in_v.texcoord;
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
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      int u_xlatb0;
      float2 u_xlat1_d;
      float3 u_xlat2_d;
      float2 u_xlat3;
      float2 u_xlat4;
      float3 u_xlat5;
      float2 u_xlat6;
      float3 u_xlat10_6;
      float2 u_xlat7;
      float2 u_xlat10;
      float2 u_xlat11;
      int u_xlati11;
      float u_xlat13;
      float u_xlat16;
      int u_xlatb16;
      float u_xlat17;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = (in_f.texcoord1.xy / in_f.texcoord1.ww);
          u_xlat10.x = tex2D(_CameraDepthTexture, u_xlat0_d.xy).x;
          u_xlat10.x = ((_ZBufferParams.z * u_xlat10.x) + _ZBufferParams.w);
          u_xlat10.x = (float(1) / u_xlat10.x);
          u_xlat10.x = (u_xlat10.x + (-_ProjectionParams.y));
          u_xlat10.y = (in_f.texcoord1.z + (-_ProjectionParams.y));
          u_xlat10.xy = max(u_xlat10.xy, float2(0, 0));
          u_xlat1_d.xy = ((in_f.texcoord.xy * float2(2, 2)) + float2(-1, (-1)));
          u_xlat11.xy = trunc(u_xlat1_d.xy);
          u_xlat1_d.xy = ((-u_xlat11.xy) + u_xlat1_d.xy);
          u_xlat1_d.xy = ((u_xlat1_d.xy * _WaterUV.xy) + (-_WaterUV.zz));
          u_xlat2_d.x = 1;
          u_xlat7.xy = u_xlat1_d.xy;
          u_xlati11 = 0;
          while(true)
          {
              u_xlat16 = float(u_xlati11);
              #ifdef UNITY_ADRENO_ES3
              u_xlatb16 = (u_xlat16>=_WaterUV.w);
              #else
              u_xlatb16 = (u_xlat16>=_WaterUV.w);
              #endif
              if(u_xlatb16)
              {
                  break;
              }
              u_xlati11 = (u_xlati11 + 1);
              u_xlat16 = float(u_xlati11);
              u_xlat16 = (3.5 / u_xlat16);
              u_xlat16 = ((-u_xlat16) + 1);
              u_xlat17 = ((_Time.y * u_xlat16) + (-u_xlat7.x));
              u_xlat17 = cos(u_xlat17);
              u_xlat3.x = ((_Time.y * u_xlat16) + u_xlat7.y);
              u_xlat3.x = sin(u_xlat3.x);
              u_xlat3.x = (u_xlat17 + u_xlat3.x);
              u_xlat17 = ((_Time.y * u_xlat16) + (-u_xlat7.y));
              u_xlat17 = sin(u_xlat17);
              u_xlat13 = ((_Time.y * u_xlat16) + u_xlat7.x);
              u_xlat13 = cos(u_xlat13);
              u_xlat3.y = (u_xlat17 + u_xlat13);
              u_xlat7.xy = (u_xlat1_d.xy + u_xlat3.xy);
              u_xlat3.xy = ((_Time.yy * float2(u_xlat16, u_xlat16)) + u_xlat7.xy);
              u_xlat16 = sin(u_xlat3.x);
              u_xlat16 = (u_xlat16 * 200);
              u_xlat4.x = (u_xlat1_d.x / u_xlat16);
              u_xlat16 = cos(u_xlat3.y);
              u_xlat16 = (u_xlat16 * 200);
              u_xlat4.y = (u_xlat1_d.y / u_xlat16);
              u_xlat16 = length(u_xlat4.xy);
              u_xlat16 = (float(1) / u_xlat16);
              u_xlat2_d.x = (u_xlat16 + u_xlat2_d.x);
          }
          u_xlat1_d.x = (u_xlat2_d.x / _WaterUV.w);
          u_xlat1_d.x = log2(u_xlat1_d.x);
          u_xlat1_d.x = (u_xlat1_d.x * 1.39999998);
          u_xlat1_d.x = exp2(u_xlat1_d.x);
          u_xlat1_d.x = ((-u_xlat1_d.x) + 1.16999996);
          u_xlat1_d.x = (abs(u_xlat1_d.x) * abs(u_xlat1_d.x));
          u_xlat1_d.x = (u_xlat1_d.x * u_xlat1_d.x);
          u_xlat1_d.x = (u_xlat1_d.x * u_xlat1_d.x);
          u_xlat1_d.x = min(u_xlat1_d.x, 1);
          u_xlat6.xy = ((-u_xlat0_d.xy) + u_xlat1_d.xx);
          u_xlat0_d.xy = ((u_xlat6.xy * float2(0.00999999978, 0.00999999978)) + u_xlat0_d.xy);
          u_xlat10_6.xyz = tex2D(_GrabpassTex_Skill, u_xlat0_d.xy).xyz;
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0 = (DepthTextureActive==0);
          #else
          u_xlatb0 = (DepthTextureActive==0);
          #endif
          u_xlat5.x = ((-u_xlat10.y) + u_xlat10.x);
          u_xlat5.x = (u_xlat5.x / _DepthSlider);
          #ifdef UNITY_ADRENO_ES3
          u_xlat5.x = min(max(u_xlat5.x, 0), 1);
          #else
          u_xlat5.x = clamp(u_xlat5.x, 0, 1);
          #endif
          u_xlat5.x = ((-u_xlat5.x) + 1);
          u_xlat5.xyz = (u_xlat5.xxx * _DepthColor.xyz);
          u_xlat0_d.xyz = (int(u_xlatb0))?(float3(0, 0, 0)):(u_xlat5.xyz);
          u_xlat0_d.xyz = ((u_xlat1_d.xxx * _MainColor.xyz) + u_xlat0_d.xyz);
          u_xlat0_d.xyz = ((-u_xlat0_d.xyz) + float3(1, 1, 1));
          u_xlat2_d.xyz = ((-_BaseColor.xyz) + float3(1, 1, 1));
          u_xlat0_d.xyz = (((-u_xlat0_d.xyz) * u_xlat2_d.xyz) + float3(1, 1, 1));
          #ifdef UNITY_ADRENO_ES3
          u_xlat0_d.xyz = min(max(u_xlat0_d.xyz, 0), 1);
          #else
          u_xlat0_d.xyz = clamp(u_xlat0_d.xyz, 0, 1);
          #endif
          out_f.color.xyz = (u_xlat10_6.xyz + u_xlat0_d.xyz);
          out_f.color.w = (in_f.color.w * _Opacity);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
