package {
	import flash.display.MovieClip;
	import flash.events.*; 
	import flash.ui.*;
	import common.TRegistry;

	public class AlienInvasion extends MovieClip {
		private var ufo:UFO;
		private var tank:Tank;
		
		public function AlienInvasion() {			
			TRegistry.instance.setValue("stage", stage);
			TRegistry.instance.setValue("groundPosition", 500);
			
			tank = new Tank();
			TRegistry.instance.setValue("Tank", tank);
			tank.x = stage.stageWidth / 2;
			tank.y = TRegistry.instance.getValue("groundPosition") - 100;
			
			var enemies:Array = new Array();
			TRegistry.instance.setValue("Enemies", enemies);
			var ufo = new UFO()
			enemies.push(ufo);
			ufo.x = 100;
			ufo.y = 100;
			/*ufo = new UFO()
			enemies.push(ufo);
			ufo.x = 200;
			ufo.y = 200;
			ufo = new UFO()
			enemies.push(ufo);
			ufo.x = 300;
			ufo.y = 300;*/
		}
	}
}