using System;
using UnityEngine;

public class OnMove : StateMachineBehaviour
{
	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		animator.ResetTrigger("Hit_back");
		animator.ResetTrigger("Hit_front");
	}
}