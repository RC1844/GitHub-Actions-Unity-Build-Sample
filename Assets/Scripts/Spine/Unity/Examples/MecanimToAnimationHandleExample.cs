using System;
using UnityEngine;

namespace Spine.Unity.Examples
{
	public class MecanimToAnimationHandleExample : StateMachineBehaviour
	{
		public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
		{
			if (!this.initialized)
			{
				this.animationHandle = animator.GetComponent<SkeletonAnimationHandleExample>();
				this.initialized = true;
			}
			this.animationHandle.PlayAnimationForState(stateInfo.shortNameHash, layerIndex);
		}

		private SkeletonAnimationHandleExample animationHandle;

		private bool initialized;
	}
}
