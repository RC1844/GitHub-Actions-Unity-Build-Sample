using System;
using UnityEngine;

public class OnIdle : StateMachineBehaviour
{
	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		animator.ResetTrigger("Hit_back");
		animator.ResetTrigger("Hit_front");
	}
}
