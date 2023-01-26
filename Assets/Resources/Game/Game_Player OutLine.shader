Shader "Game/Player OutLine"
{
  Properties
  {
    _Color ("Main Color", Color) = (0.5,0.5,0.5,1)
    _OutlineColor ("Outline Color", Color) = (0,0,0,1)
    _Outline ("Outline width", Range(0, 0.03)) = 0.0005
    _MainTex ("Tint Color (RGB)", 2D) = "white" {}
    _BumpMap ("Normalmap", 2D) = "bump" {}
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "Transparent"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "LIGHTMODE" = "ALWAYS"
        "QUEUE" = "Transparent"
      }
      ZTest Greater
      ZWrite Off
      Cull Off
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
      //uniform float4x4 UNITY_MATRIX_P;
      //uniform float4x4 unity_MatrixInvV;
      //uniform float4x4 unity_MatrixVP;
      uniform float _Outline;
      uniform float4 _OutlineColor;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
      };
      
      struct OUT_Data_Vert
      {
          float4 color :COLOR0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float3 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float u_xlat6;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.xyz = mul(unity_MatrixInvV, unity_WorldToObject[0]);
          u_xlat0.x = dot(u_xlat0.xyz, in_v.normal.xyz);
          u_xlat0.xy = (u_xlat0.xx * conv_mxt4x4_1(UNITY_MATRIX_P).xy);
          u_xlat1.xyz = (conv_mxt4x4_1(unity_WorldToObject).xyz * conv_mxt4x4_0(unity_MatrixInvV).yyy);
          u_xlat1.xyz = ((conv_mxt4x4_0(unity_WorldToObject).xyz * conv_mxt4x4_0(unity_MatrixInvV).xxx) + u_xlat1.xyz);
          u_xlat1.xyz = ((conv_mxt4x4_2(unity_WorldToObject).xyz * conv_mxt4x4_0(unity_MatrixInvV).zzz) + u_xlat1.xyz);
          u_xlat1.xyz = ((conv_mxt4x4_3(unity_WorldToObject).xyz * conv_mxt4x4_0(unity_MatrixInvV).www) + u_xlat1.xyz);
          u_xlat6 = dot(u_xlat1.xyz, in_v.normal.xyz);
          u_xlat0.xy = ((conv_mxt4x4_0(UNITY_MATRIX_P).xy * float2(u_xlat6, u_xlat6)) + u_xlat0.xy);
          u_xlat1 = UnityObjectToClipPos(in_v.vertex);
          u_xlat0.xy = (u_xlat0.xy * u_xlat1.zz);
          out_v.vertex.xy = ((u_xlat0.xy * float2(_Outline, _Outline)) + u_xlat1.xy);
          out_v.vertex.zw = u_xlat1.zw;
          out_v.color = _OutlineColor;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          out_f.color = in_f.color;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: BASE
    {
      Name "BASE"
      Tags
      { 
        "LIGHTMODE" = "Vertex"
        "QUEUE" = "Transparent"
      }
      Fog
      { 
        Mode  Off
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
      //uniform float4 unity_LightColor[8];
      //uniform float4 unity_LightPosition[8];
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4 glstate_lightmodel_ambient;
      //uniform float4x4 unity_MatrixInvV;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _Color;
      uniform int4 unity_VertexLightParams;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float3 vertex :POSITION0;
          float3 normal :NORMAL0;
          float3 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 phase0_Output0_1;
      float4 u_xlat0;
      float4 u_xlat1;
      int u_xlatb1;
      float3 u_xlat2;
      float3 u_xlat16_3;
      float3 u_xlat16_4;
      float3 u_xlat16_5;
      float u_xlat18;
      int u_xlati18;
      float u_xlat16_21;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.xyz = (conv_mxt4x4_1(unity_WorldToObject).xyz * conv_mxt4x4_0(unity_MatrixInvV).yyy);
          u_xlat0.xyz = ((conv_mxt4x4_0(unity_WorldToObject).xyz * conv_mxt4x4_0(unity_MatrixInvV).xxx) + u_xlat0.xyz);
          u_xlat0.xyz = ((conv_mxt4x4_2(unity_WorldToObject).xyz * conv_mxt4x4_0(unity_MatrixInvV).zzz) + u_xlat0.xyz);
          u_xlat0.xyz = ((conv_mxt4x4_3(unity_WorldToObject).xyz * conv_mxt4x4_0(unity_MatrixInvV).www) + u_xlat0.xyz);
          u_xlat1.xyz = mul(unity_MatrixInvV, unity_WorldToObject[0]);
          u_xlat2.xyz = (conv_mxt4x4_1(unity_WorldToObject).xyz * conv_mxt4x4_2(unity_MatrixInvV).yyy);
          u_xlat2.xyz = ((conv_mxt4x4_0(unity_WorldToObject).xyz * conv_mxt4x4_2(unity_MatrixInvV).xxx) + u_xlat2.xyz);
          u_xlat2.xyz = ((conv_mxt4x4_2(unity_WorldToObject).xyz * conv_mxt4x4_2(unity_MatrixInvV).zzz) + u_xlat2.xyz);
          u_xlat2.xyz = ((conv_mxt4x4_3(unity_WorldToObject).xyz * conv_mxt4x4_2(unity_MatrixInvV).www) + u_xlat2.xyz);
          u_xlat0.x = dot(u_xlat0.xyz, in_v.normal.xyz);
          u_xlat0.y = dot(u_xlat1.xyz, in_v.normal.xyz);
          u_xlat0.z = dot(u_xlat2.xyz, in_v.normal.xyz);
          u_xlat0.xyz = normalize(u_xlat0.xyz);
          u_xlat16_3.xyz = (glstate_lightmodel_ambient.xyz * _Color.xyz);
          u_xlat16_4.xyz = u_xlat16_3.xyz;
          int u_xlati_loop_1 = 0;
          while((u_xlati_loop_1<unity_VertexLightParams.x))
          {
              u_xlat16_21 = dot(u_xlat0.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
              u_xlat16_21 = max(u_xlat16_21, 0);
              u_xlat16_5.xyz = (float3(u_xlat16_21, u_xlat16_21, u_xlat16_21) * _Color.xyz);
              u_xlat16_5.xyz = (u_xlat16_5.xyz * unity_LightColor[u_xlati_loop_1].xyz);
              u_xlat16_5.xyz = (u_xlat16_5.xyz * float3(0.5, 0.5, 0.5));
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, float3(1, 1, 1));
              u_xlat16_4.xyz = (u_xlat16_4.xyz + u_xlat16_5.xyz);
              u_xlati_loop_1 = (u_xlati_loop_1 + 1);
          }
          out_v.color.xyz = u_xlat16_4.xyz;
          #ifdef UNITY_ADRENO_ES3
          out_v.color.xyz = min(max(out_v.color.xyz, 0), 1);
          #else
          out_v.color.xyz = clamp(out_v.color.xyz, 0, 1);
          #endif
          out_v.color.w = _Color.w;
          #ifdef UNITY_ADRENO_ES3
          out_v.color.w = min(max(out_v.color.w, 0), 1);
          #else
          out_v.color.w = clamp(out_v.color.w, 0, 1);
          #endif
          phase0_Output0_1 = ((in_v.texcoord.xyxy * _MainTex_ST.xyxy) + _MainTex_ST.zwzw);
          out_v.vertex = UnityObjectToClipPos(float4(in_v.vertex, 0));
          out_v.texcoord = phase0_Output0_1.xy;
          out_v.texcoord1 = phase0_Output0_1.zw;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_0 = (u_xlat16_0 * _Color);
          u_xlat16_0 = (u_xlat16_0 * in_f.color);
          out_f.color = (u_xlat16_0 + u_xlat16_0);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Diffuse"
}
