Shader "TN/EZPBR"
{
  Properties
  {
    _MainTex ("Texture", 2D) = "white" {}
    _EffectColor ("Color", Color) = (1,1,1,1)
    _NormalTex ("NormalTex", 2D) = "bump" {}
    _Normal_Intensity ("Normal_Intensity", Range(0, 10)) = 1
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "RenderType" = "Opaque"
      }
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
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _WorldSpaceLightPos0;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4 glstate_lightmodel_ambient;
      uniform float4 _LightColor0;
      uniform float4 _MainTex_ST;
      uniform float4 _NormalTex_ST;
      uniform float4 _EffectColor;
      uniform float _Normal_Intensity;
      uniform sampler2D _NormalTex;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
          float3 normal :NORMAL0;
          float4 tangent :TANGENT0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 color :COLOR0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float4 color :COLOR0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float3 u_xlat2;
      float u_xlat9;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          out_v.texcoord.xy = in_v.texcoord.xy;
          out_v.color = in_v.color;
          u_xlat0.x = dot(in_v.normal.xyz, in_v.normal.xyz);
          u_xlat0.x = rsqrt(u_xlat0.x);
          u_xlat0.xyz = (u_xlat0.xxx * in_v.normal.zxy);
          u_xlat1.xyz = normalize(in_v.tangent).xyz;
          u_xlat2.xyz = (u_xlat0.xyz * u_xlat1.xyz);
          u_xlat0.xyz = ((u_xlat0.zxy * u_xlat1.yzx) + (-u_xlat2.xyz));
          u_xlat0.xyz = (u_xlat0.xyz * in_v.tangent.www);
          u_xlat1.xyz = (_WorldSpaceLightPos0.yyy * conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat1.xyz = ((conv_mxt4x4_0(unity_WorldToObject).xyz * _WorldSpaceLightPos0.xxx) + u_xlat1.xyz);
          u_xlat1.xyz = ((conv_mxt4x4_2(unity_WorldToObject).xyz * _WorldSpaceLightPos0.zzz) + u_xlat1.xyz);
          u_xlat1.xyz = ((conv_mxt4x4_3(unity_WorldToObject).xyz * _WorldSpaceLightPos0.www) + u_xlat1.xyz);
          u_xlat1.xyz = (((-in_v.vertex.xyz) * _WorldSpaceLightPos0.www) + u_xlat1.xyz);
          out_v.texcoord1.y = dot(u_xlat0.xyz, u_xlat1.xyz);
          out_v.texcoord1.x = dot(in_v.tangent.xyz, u_xlat1.xyz);
          out_v.texcoord1.z = dot(in_v.normal.xyz, u_xlat1.xyz);
          u_xlat1.xyz = mul(unity_WorldToObject, _WorldSpaceCameraPos.xyz);
          u_xlat1.xyz = (u_xlat1.xyz + (-in_v.vertex.xyz));
          out_v.texcoord2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
          out_v.texcoord2.x = dot(in_v.tangent.xyz, u_xlat1.xyz);
          out_v.texcoord2.z = dot(in_v.normal.xyz, u_xlat1.xyz);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat0_d;
      float3 u_xlat1_d;
      float3 u_xlat2_d;
      float3 u_xlat3;
      float2 u_xlat10_3;
      float4 u_xlat4;
      float4 u_xlat16_4;
      float3 u_xlat5;
      float2 u_xlat6;
      float3 u_xlat7;
      float u_xlat14;
      float u_xlat22;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d = dot(in_f.texcoord1.xyz, in_f.texcoord1.xyz);
          u_xlat0_d = rsqrt(u_xlat0_d);
          u_xlat7.x = dot(in_f.texcoord2.xyz, in_f.texcoord2.xyz);
          u_xlat7.x = rsqrt(u_xlat7.x);
          u_xlat7.xyz = (u_xlat7.xxx * in_f.texcoord2.xyz);
          u_xlat1_d.xyz = ((in_f.texcoord1.xyz * float3(u_xlat0_d, u_xlat0_d, u_xlat0_d)) + u_xlat7.xyz);
          u_xlat2_d.xyz = (float3(u_xlat0_d, u_xlat0_d, u_xlat0_d) * in_f.texcoord1.xyz);
          u_xlat1_d.xyz = normalize(u_xlat1_d.xyz);
          u_xlat3.xy = TRANSFORM_TEX(in_f.texcoord.xy, _NormalTex);
          u_xlat10_3.xy = tex2D(_NormalTex, u_xlat3.xy).xy;
          u_xlat16_4.xy = ((u_xlat10_3.xy * float2(2, 2)) + float2(-1, (-1)));
          u_xlat3.xy = (u_xlat16_4.xy * float2(_Normal_Intensity, _Normal_Intensity));
          u_xlat0_d = dot(u_xlat3.xy, u_xlat3.xy);
          u_xlat0_d = min(u_xlat0_d, 1);
          u_xlat0_d = ((-u_xlat0_d) + 1);
          u_xlat3.z = sqrt(u_xlat0_d);
          u_xlat0_d = dot(u_xlat3.xyz, u_xlat1_d.xyz);
          u_xlat0_d = max(u_xlat0_d, 0);
          u_xlat0_d = log2(u_xlat0_d);
          u_xlat0_d = (u_xlat0_d * 100);
          u_xlat0_d = exp2(u_xlat0_d);
          u_xlat16_4.xyz = (_LightColor0.xyz + float3(0.200000003, 0.200000003, 0.200000003));
          u_xlat1_d.xyz = (float3(u_xlat0_d, u_xlat0_d, u_xlat0_d) * u_xlat16_4.xyz);
          u_xlat5.xyz = (u_xlat16_4.xyz * _EffectColor.xyz);
          u_xlat6.xy = TRANSFORM_TEX(in_f.texcoord.xy, _MainTex);
          u_xlat16_4 = tex2D(_MainTex, u_xlat6.xy);
          u_xlat4 = (u_xlat16_4 * _EffectColor);
          u_xlat1_d.xyz = ((u_xlat4.xyz * in_f.color.xyz) + u_xlat1_d.xyz);
          out_f.color.w = (u_xlat4.w * in_f.color.w);
          u_xlat0_d = dot(u_xlat3.xyz, u_xlat2_d.xyz);
          u_xlat22 = dot(u_xlat3.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat22 = min(max(u_xlat22, 0), 1);
          #else
          u_xlat22 = clamp(u_xlat22, 0, 1);
          #endif
          u_xlat7.x = dot(u_xlat2_d.xyz, (-u_xlat7.xyz));
          #ifdef UNITY_ADRENO_ES3
          u_xlat7.x = min(max(u_xlat7.x, 0), 1);
          #else
          u_xlat7.x = clamp(u_xlat7.x, 0, 1);
          #endif
          u_xlat7.x = max(u_xlat7.x, 0.25);
          u_xlat14 = ((-u_xlat22) + 1);
          u_xlat0_d = max(u_xlat0_d, 0.699999988);
          u_xlat1_d.xyz = ((u_xlat5.xyz * float3(u_xlat0_d, u_xlat0_d, u_xlat0_d)) + u_xlat1_d.xyz);
          u_xlat1_d.xyz = ((glstate_lightmodel_ambient.xyz * float3(0.300000012, 0.300000012, 0.300000012)) + u_xlat1_d.xyz);
          u_xlat0_d = (u_xlat14 * u_xlat14);
          u_xlat0_d = (u_xlat0_d * u_xlat0_d);
          u_xlat0_d = (u_xlat0_d * u_xlat14);
          out_f.color.xyz = ((float3(u_xlat0_d, u_xlat0_d, u_xlat0_d) * u_xlat7.xxx) + u_xlat1_d.xyz);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: ShadowCaster陰影投射
    {
      Name "ShadowCaster陰影投射"
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
  FallBack Off
}
