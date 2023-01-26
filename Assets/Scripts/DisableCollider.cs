using System;
using System.Collections.Generic;
using UnityEngine;

public class DisableCollider : StateMachineBehaviour
{
	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		foreach (Collider collider in animator.GetComponentsInChildren<Collider>())
		{
			if (!(collider.name == animator.name))
			{
				collider.enabled = false;
				this.ColliderList.Add(collider);
			}
		}
	}

	public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		foreach (Collider collider in this.ColliderList)
		{
			collider.enabled = true;
		}
		this.ColliderList.Clear();
	}

	private List<Collider> ColliderList = new List<Collider>();
}
