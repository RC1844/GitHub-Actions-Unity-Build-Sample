using System;
using UnityEngine;

public class HideRenderer : StateMachineBehaviour
{
	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		CharacterControl component = animator.gameObject.GetComponent<CharacterControl>();
		if (component != null)
		{
			component.Visible = false;
		}
	}

	public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		CharacterControl component = animator.gameObject.GetComponent<CharacterControl>();
		if (component != null)
		{
			component.Visible = true;
		}
	}
}
