using System;
using UnityEngine;

public class Sound : StateMachineBehaviour
{
	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (Sound.AudioSourceInstance == null)
		{
			Sound.AudioSourceInstance = FileSystem.InstantiateObject<AudioSource>(this.AudioSourcePrefab, Vector3.zero, Quaternion.identity, null);
		}
		if (Sound.AudioSourceInstance != null)
		{
			Sound.AudioSourceInstance.Play();
		}
	}

	private void Start()
	{
	}

	public AudioSource AudioSourcePrefab;

	public static AudioSource AudioSourceInstance;
}
