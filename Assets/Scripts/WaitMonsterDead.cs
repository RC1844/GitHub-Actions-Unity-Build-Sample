using System;
using UnityEngine;

public class WaitMonsterDead : StateMachineBehaviour
{
	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (BattleStageControl.Instance != null)
		{
			BattleStageControl.Instance.CharacterMap.TryGetValue(this.MonsterName, out this.TargetMonster);
		}
	}

	public override void OnStateUpdate(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (this.TargetMonster == null)
		{
			return;
		}
		if (this.TargetMonster.IsDead)
		{
			if (this.EnterTime == 0f)
			{
				this.EnterTime = Time.time;
			}
			if (this.EnterTime + 1.5f < Time.time)
			{
				animator.SetBool(this.BoolName, this.SetBool);
			}
		}
	}

	public string MonsterName = string.Empty;

	public string BoolName = string.Empty;

	public bool SetBool = true;

	private CharacterControl TargetMonster;

	private float EnterTime;
}
