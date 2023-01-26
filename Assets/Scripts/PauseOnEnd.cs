using System;
using UnityEngine;

public class PauseOnEnd : StateMachineBehaviour
{
	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
	}

	public override void OnStateUpdate(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
	}

	public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		animator.speed = 0f;
		CharacterAnimatorControl component = animator.gameObject.GetComponent<CharacterAnimatorControl>();
		if (component != null)
		{
			component.PauseAnimator(this.PauseTime);
		}
	}

	public float PauseTime;
}
