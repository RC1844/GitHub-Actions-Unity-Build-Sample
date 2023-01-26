using System;
using System.Collections;
using UnityEngine;

public class IconFlashControl : StateMachineBehaviour
{
	private IEnumerator DelayPlay(Animator animator)
	{
		yield return new WaitForSeconds(MathHelper.RandomFloat(this.MinSec, this.MaxSec));
		if (animator != null)
		{
			animator.SetTrigger(IconFlashControl.Flash);
		}
		yield break;
	}

	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		GameControl.Instance.StartCoroutine(this.DelayPlay(animator));
	}

	private static readonly int Flash = Animator.StringToHash("Flash");

	public float MinSec;

	public float MaxSec = 5f;
}
