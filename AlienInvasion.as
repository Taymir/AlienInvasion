package {
	import flash.display.MovieClip;
	import flash.events.*; 
	import flash.ui.*;
	import common.TRegistry;

	public class AlienInvasion extends MovieClip {
		private var ufo:UFO;
		private var tank:Tank;
		
		public function AlienInvasion() {
			var sheeps:Array = new Array();
			
			TRegistry.instance.setValue("stage", stage);
			
			ufo = new UFO();
			ufo.x = stage.stageWidth / 2;
			ufo.y = stage.stageHeight / 2;
			
			stage.addChild(ufo);
			
			tank = new Tank();
			tank.x = stage.stageWidth / 2;
			tank.y = 500;
			
			stage.addChild(tank);
		}
	}
}