package {
	import flash.display.MovieClip;
	import flash.events.*; 
	import flash.ui.*;
	
	/* Пользовательские библиотеки */
	import Missle;

	public class AlienInvasion extends MovieClip {
		private var ufo:UFO;
		public var sheeps:Array;
		
		public function AlienInvasion() {
			ufo = new UFO(this.stage);
			ufo.x = stage.stageWidth / 2;
			ufo.y = stage.stageHeight / 2;
			
			stage.addChild(ufo);
			
			sheeps = new Array();
			
			addSheep(100, 500);
			addSheep(400, 500);
			addSheep(600, 500);
			addSheep(200, 500);
		}
		
		private function addSheep(x: int, y: int) : Sheep
		{
			var s:Sheep;
			
			s = new Sheep();
			s.x = x;
			s.y = y;
			stage.addChild(s);
			
			this.sheeps.push(s);
			
			return s;
		}
	}
}