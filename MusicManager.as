package  
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import common.TRegistry;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Taymir
	 */
	public class MusicManager
	{
		private const defPath: String = "music/";
		private const defExt: String = ".mp3";
		
		private var sndTransform: SoundTransform;
		private var tracks: Dictionary = new Dictionary();
		private var currentChannel: SoundChannel;
		private var autoplay: String = "";
		
		public function MusicManager(sndTransform: SoundTransform = null) 
		{
			if (sndTransform == null)
				sndTransform = new SoundTransform(1.0);
				
			this.sndTransform = sndTransform;
			
			if (!TRegistry.instance.getValue("config_play_music"))
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
			
			if (currentChannel != null)
				currentChannel.soundTransform = sndTransform;
		}
		
		public function addTrack(trackName: String, track: Sound)
		{
			tracks[trackName] = track;
		}
		
		public function loadTrack(trackName: String, trackUrl: String = null)
		{
			if (trackUrl == null)
			{
				trackUrl = this.defPath + trackName + this.defExt;
			}
			
			var track:Sound = new Sound();
			track.load(new URLRequest(trackUrl));
			track.addEventListener(Event.COMPLETE, 
			function(e:Event): void {
				addTrack(trackName, track);
				
				if (autoplay == trackName)
					play(trackName);
			}
			);
		}
		
		public function play(trackName:String)
		{
			if (tracks[trackName] == undefined)
			{
				autoplay = trackName;
			}
			else
			{
				if (currentChannel != null)
					currentChannel.stop();
				currentChannel = (tracks[trackName] as Sound).play(0, int.MAX_VALUE, this.sndTransform);
			}
		}
		
	}

}