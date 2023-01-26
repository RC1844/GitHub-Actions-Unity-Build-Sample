using System;
using UnityEngine;

public class DialogShowTypeFSMControl : StateMachineBehaviour
{
	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		animator.SetBool(DialogShowTypeFSMControl.StateChange, false);
	}

	public static int StateChange = Animator.StringToHash("StateChange");
}
