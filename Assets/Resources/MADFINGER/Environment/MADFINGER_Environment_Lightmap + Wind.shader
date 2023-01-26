Shader "MADFINGER/Environment/Lightmap + Wind"
{
  Properties
  {
    _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
    _Wind ("Wind params", Vector) = (1,1,1,1)
    _WindEdgeFlutter ("Wind edge fultter factor", float) = 0.5
    _WindEdgeFlutterFreqScale ("Wind edge fultter freq scale", float) = 0.5
  }
  SubShader
  {
    Tags
    { 
      "LIGHTMODE" = "FORWARDBASE"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    LOD 100
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 100
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
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _Wind;
      uniform float4 _MainTex_ST;
      uniform float _WindEdgeFlutter;
      uniform float _WindEdgeFlutterFreqScale;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 texcoord :TEXCOORD0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord2 :TEXCOORD2;
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
      float u_xlat8;
      float u_xlat12;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.x = conv_mxt4x4_0(unity_ObjectToWorld).w;
          u_xlat0.y = conv_mxt4x4_1(unity_ObjectToWorld).w;
          u_xlat0.z = conv_mxt4x4_2(unity_ObjectToWorld).w;
          u_xlat0.y = dot(u_xlat0.xyz, float3(1, 1, 1));
          u_xlat8 = (u_xlat0.y + _WindEdgeFlutter);
          u_xlat0.x = dot(in_v.vertex.xyz, float3(u_xlat8, u_xlat8, u_xlat8));
          u_xlat0 = ((_Time.yyyy * float4(float4(_WindEdgeFlutterFreqScale, _WindEdgeFlutterFreqScale, _WindEdgeFlutterFreqScale, _WindEdgeFlutterFreqScale))) + u_xlat0.xxyy);
          u_xlat0 = (u_xlat0 * float4(1.97500002, 0.792999983, 0.375, 0.193000004));
          u_xlat0 = frac(u_xlat0);
          u_xlat0 = ((u_xlat0 * float4(2, 2, 2, 2)) + float4(-0.5, (-0.5), (-0.5), (-0.5)));
          u_xlat0 = frac(u_xlat0);
          u_xlat0 = ((u_xlat0 * float4(2, 2, 2, 2)) + float4(-1, (-1), (-1), (-1)));
          u_xlat1 = (abs(u_xlat0) * abs(u_xlat0));
          u_xlat0 = (((-abs(u_xlat0)) * float4(2, 2, 2, 2)) + float4(3, 3, 3, 3));
          u_xlat0 = (u_xlat0 * u_xlat1);
          u_xlat0.xyz = (u_xlat0.ywy + u_xlat0.xzx);
          u_xlat1.xyz = (conv_mxt4x4_1(unity_WorldToObject).xyz * _Wind.yyy);
          u_xlat1.xyz = ((conv_mxt4x4_0(unity_WorldToObject).xyz * _Wind.xxx) + u_xlat1.xyz);
          u_xlat1.xyz = ((conv_mxt4x4_2(unity_WorldToObject).xyz * _Wind.zzz) + u_xlat1.xyz);
          u_xlat2.xyz = (u_xlat0.yyy * u_xlat1.xyz);
          u_xlat2.xyz = (u_xlat2.xyz * in_v.color.www);
          u_xlat12 = (_WindEdgeFlutter * 0.100000001);
          u_xlat3.xz = (float2(u_xlat12, u_xlat12) * in_v.normal.xz);
          u_xlat3.y = (in_v.color.w * 0.300000012);
          u_xlat0.xyz = ((u_xlat0.xyz * u_xlat3.xyz) + u_xlat2.xyz);
          u_xlat12 = (in_v.color.w * _Wind.w);
          u_xlat0.xyz = ((u_xlat0.xyz * float3(u_xlat12, u_xlat12, u_xlat12)) + in_v.vertex.xyz);
          u_xlat0.xyz = ((in_v.color.www * u_xlat1.xyz) + u_xlat0.xyz);
          out_v.vertex = UnityObjectToClipPos(u_xlat0);
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.texcoord2.xyz = in_v.color.xyz;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy);
          out_f.color = u_xlat16_0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
