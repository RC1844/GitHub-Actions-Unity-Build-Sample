Shader "Game/Rim Light"
{
  Properties
  {
    _Color ("Main Color", Color) = (1,1,1,1)
    _RimColor ("Rim Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB)", 2D) = "white" {}
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4 _RimColor;
      uniform float4 _Color;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float3 color :COLOR0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float3 color :COLOR0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float u_xlat2;
      float u_xlat6;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          out_v.texcoord.xy = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          u_xlat0.xyz = mul(unity_WorldToObject, _WorldSpaceCameraPos.xyz);
          u_xlat0.xyz = (u_xlat0.xyz + (-in_v.vertex.xyz));
          u_xlat0.xyz = normalize(u_xlat0.xyz);
          u_xlat0.x = dot(in_v.normal.xyz, u_xlat0.xyz);
          u_xlat0.x = ((-u_xlat0.x) + 0.699999988);
          u_xlat0.x = (u_xlat0.x * 1.42857146);
          #ifdef UNITY_ADRENO_ES3
          u_xlat0.x = min(max(u_xlat0.x, 0), 1);
          #else
          u_xlat0.x = clamp(u_xlat0.x, 0, 1);
          #endif
          u_xlat2 = ((u_xlat0.x * (-2)) + 3);
          u_xlat0.x = (u_xlat0.x * u_xlat0.x);
          u_xlat0.x = (u_xlat0.x * u_xlat2);
          out_v.color.xyz = (u_xlat0.xxx * _RimColor.xyz);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      float u_xlat3;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat3 = (u_xlat16_0.w * _Color.w);
          out_f.color.xyz = ((u_xlat16_0.xyz * _Color.xyz) + in_f.color.xyz);
          out_f.color.w = u_xlat3;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
