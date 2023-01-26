using System;
using UnityEngine;

public class MoveLimit : StateMachineBehaviour
{
	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (this.CharacterControl == null)
		{
			this.CharacterControl = animator.gameObject.GetComponent<CharacterControl>();
		}
		if (this.CharacterControl == null)
		{
			return;
		}
		this.CharacterControl.CharacterAnimatorControl.MotionMoveLimitTime = Time.time + 0.1f;
	}

	public override void OnStateUpdate(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (this.CharacterControl == null)
		{
			return;
		}
		if (this.CancelNormalizedTime == 0f)
		{
			this.CharacterControl.CharacterAnimatorControl.MotionMoveLimitTime = Time.time + 0.1f;
		}
		if (stateInfo.normalizedTime > this.CancelNormalizedTime)
		{
			this.CharacterControl.CharacterAnimatorControl.MotionMoveLimitTime = 0f;
			return;
		}
		this.CharacterControl.CharacterAnimatorControl.MotionMoveLimitTime = Time.time + 0.1f;
	}

	public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (this.CharacterControl == null)
		{
			this.CharacterControl = animator.gameObject.GetComponent<CharacterControl>();
		}
		if (this.CharacterControl == null)
		{
			return;
		}
		this.CharacterControl.CharacterAnimatorControl.MotionMoveLimitTime = 0f;
	}

	private CharacterControl CharacterControl;

	public float CancelNormalizedTime;
}
