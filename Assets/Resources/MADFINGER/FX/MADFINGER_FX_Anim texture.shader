Shader "MADFINGER/FX/Anim texture"
{
  Properties
  {
    _MainTex ("Base (RGB)", 2D) = "white" {}
    _NumTexTiles ("Num tex tiles", Vector) = (4,4,0,0)
    _ReplaySpeed ("Replay speed - FPS", float) = 4
    _Color ("Color", Color) = (1,1,1,1)
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
        "IGNOREPROJECTOR" = "true"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Blend One One
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _Color;
      uniform float4 _NumTexTiles;
      uniform float _ReplaySpeed;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 texcoord :TEXCOORD0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float4 color :COLOR0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlatb1;
      float4 u_xlat2;
      float u_xlat3;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0.x = ((in_v.color.w * 60) + _Time.y);
          u_xlat3 = (u_xlat0.x * _ReplaySpeed);
          u_xlat1.x = floor(u_xlat3);
          u_xlat3 = (u_xlat1.x + 1);
          u_xlat3 = (u_xlat3 / _NumTexTiles.x);
          u_xlat1.w = floor(u_xlat3);
          u_xlat3 = (u_xlat1.x / _NumTexTiles.x);
          u_xlat1.y = floor(u_xlat3);
          u_xlat1.z = (u_xlat1.x + 1);
          u_xlat2 = (u_xlat1 / _NumTexTiles.xyxy);
          u_xlat0.w = ((u_xlat0.x * _ReplaySpeed) + (-u_xlat1.x));
          u_xlatb1 = bool4(u_xlat2 >= (-u_xlat2));
          u_xlat2 = frac(abs(u_xlat2));
          u_xlat1.x = (u_xlatb1.x)?(u_xlat2.x):((-u_xlat2.x));
          u_xlat1.y = (u_xlatb1.y)?(u_xlat2.y):((-u_xlat2.y));
          u_xlat1.z = (u_xlatb1.z)?(u_xlat2.z):((-u_xlat2.z));
          u_xlat1.w = (u_xlatb1.w)?(u_xlat2.w):((-u_xlat2.w));
          u_xlat1 = ((u_xlat1 * _NumTexTiles.xyxy) + in_v.texcoord.xyxy);
          u_xlat2 = (float4(1, 1, 1, 1) / _NumTexTiles.xyxy);
          out_v.texcoord = (u_xlat1 * u_xlat2);
          u_xlat0.xyz = (in_v.color.xyz * _Color.xyz);
          out_v.color = u_xlat0;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat16_0;
      float4 u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = tex2D(_MainTex, in_f.texcoord.zw);
          u_xlat16_1 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat0_d = (u_xlat16_0 + (-u_xlat16_1));
          u_xlat0_d = ((in_f.color.wwww * u_xlat0_d) + u_xlat16_1);
          u_xlat0_d = (u_xlat0_d * in_f.color);
          out_f.color = u_xlat0_d;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
