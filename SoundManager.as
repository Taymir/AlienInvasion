package  
{
	import common.Debug;
	import common.TRegistry;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
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
		
		public function addSound(soundName: String, sound: Sound = null)
		{
			if (sound == null)
			{
				var classRef: Class = getDefinitionByName(soundName) as Class;
				sound = new classRef() as Sound;
			}
			
			sounds[soundName] = sound;
		}
		
		public function play(soundName:String)
		{
			Debug.assert(sounds[soundName] != null, "Звук не найден");
			
			(sounds[soundName] as Sound).play(0, 0, this.sndTransform);
		}
	}

}