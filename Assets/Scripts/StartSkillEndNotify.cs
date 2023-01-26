using System;
using UnityEngine;

public class StartSkillEndNotify : StateMachineBehaviour
{
	public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		CharacterSkillControl component = animator.GetComponent<CharacterSkillControl>();
		if (component != null)
		{
			component.IsSkillStart = false;
		}
	}
}
