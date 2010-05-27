package {
	import flash.display.MovieClip;
	import flash.events.*; 
	import flash.ui.*;
	
	/* Пользовательские библиотеки */
	import Missle;

	public class AlienInvasion extends MovieClip {
		private var ufo:UFO;
		
		public function AlienInvasion() {
			ufo = new UFO(this.stage);
			ufo.x = stage.stageWidth / 2;
			ufo.y = stage.stageHeight / 2;
			
			stage.addChild(ufo);
		}
	}
}