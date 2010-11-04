package  
{
	import common.TRegistry;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Taymir
	 */
	public class SoundManager
	{
		private var sndTransform: SoundTransform;
		private var sounds: Dictionary = new Dictionary();
		
		public function SoundManager(sndTransform: SoundTransform = null) 
		{
			if (sndTransform == null)
				sndTransform = new SoundTransform(1.0);
				
			this.sndTransform = sndTransform;
			
			if (!TRegistry.instance.getValue("config_play_sounds"))
				this.mute();
		}
		
		public function mute()
		{
			if (sndTransform.volume < 0.1)
				updateVolume(1.0);
			else
				updateVolume(0.0);
		}
		
		public function updateVolume(volume: Number)
		{
			this.sndTransform.volume = volume;
		}
		
		public function addSound(soundName: String, sound: Sound)
		{
			sounds[soundName] = sound;
		}
		
		public function play(soundName:String)
		{
			(sounds[soundName] as Sound).play(0, 0, this.sndTransform);
		}
	}

}