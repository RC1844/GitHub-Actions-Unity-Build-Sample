using System;
using UnityEngine;

public class DestroySelf : StateMachineBehaviour
{
	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		animator.gameObject.SetActive(false);
		UnityEngine.Object.Destroy(animator.gameObject);
	}
}
