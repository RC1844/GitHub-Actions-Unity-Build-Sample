using System;
using System.Collections.Generic;
using UnityEngine;

public class FadeOutRenderer : StateMachineBehaviour
{
	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		this.EnterTime = Time.time;
	}

	public override void OnStateUpdate(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (this.EnterTime + this.WaitTime < Time.time && !this.IsFadeout)
		{
			this.IsFadeout = true;
			foreach (Renderer renderer in animator.GetComponentsInChildren<Renderer>())
			{
				if (string.IsNullOrEmpty(this.ExceptionName) || !renderer.name.Contains(this.ExceptionName))
				{
					List<Material> list = new List<Material>();
					list.AddRange(renderer.materials);
					int num = renderer.materials.Length;
					List<Material> list2 = new List<Material>();
					for (int j = 0; j < num; j++)
					{
						Material fadeoutMaterial = this.FadeoutMaterial;
						fadeoutMaterial.mainTexture = list[j].mainTexture;
						list2.Add(fadeoutMaterial);
					}
					renderer.materials = list2.ToArray();
					Timed timed = renderer.gameObject.GetComponent<Timed>();
					if (timed == null)
					{
						timed = renderer.gameObject.AddComponent<Timed>();
					}
					timed.m_fTime = 0f;
					timed.m_fDestruktionSpeed = this.FadeoutSpeed;
				}
			}
			if (string.IsNullOrEmpty(this.ExceptionName))
			{
				BreakObjectControl componentInParent = animator.GetComponentInParent<BreakObjectControl>();
				if (componentInParent != null)
				{
					Collider[] componentsInChildren2 = componentInParent.GetComponentsInChildren<Collider>();
					for (int i = 0; i < componentsInChildren2.Length; i++)
					{
						UnityEngine.Object.Destroy(componentsInChildren2[i]);
					}
				}
				else
				{
					Collider[] componentsInChildren2 = animator.GetComponentsInChildren<Collider>();
					for (int i = 0; i < componentsInChildren2.Length; i++)
					{
						UnityEngine.Object.Destroy(componentsInChildren2[i]);
					}
				}
			}
			animator.enabled = false;
		}
	}

	public float WaitTime = 1f;

	public Material FadeoutMaterial;

	public float FadeoutSpeed = 1f;

	public string ExceptionName = string.Empty;

	private float EnterTime;

	private bool IsFadeout;
}
