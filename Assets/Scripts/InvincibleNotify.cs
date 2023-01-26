using System;
using UnityEngine;

public class InvincibleNotify : StateMachineBehaviour
{
	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		CharacterControl component = animator.gameObject.GetComponent<CharacterControl>();
		if (component != null)
		{
			component.CharacterAnimatorControl.InvincibilityTime = Time.time + 0.1f;
		}
	}

	public override void OnStateUpdate(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		CharacterControl component = animator.gameObject.GetComponent<CharacterControl>();
		if (component != null)
		{
			component.CharacterAnimatorControl.InvincibilityTime = Time.time + 0.1f;
		}
	}

	public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		CharacterControl component = animator.gameObject.GetComponent<CharacterControl>();
		if (component != null)
		{
			component.CharacterAnimatorControl.InvincibilityTime = 0f;
		}
	}
}
