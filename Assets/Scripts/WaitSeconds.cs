using System;
using UnityEngine;

public class WaitSeconds : StateMachineBehaviour
{
	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		this.EnterTime = Time.time;
	}

	public override void OnStateUpdate(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (this.EnterTime + this.WaitTime < Time.time)
		{
			animator.SetBool(this.BoolName, this.SetBool);
		}
	}

	public float WaitTime = 1f;

	public string BoolName = string.Empty;

	public bool SetBool = true;

	private float EnterTime;
}
