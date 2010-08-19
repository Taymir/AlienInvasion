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
			
			sheeps.push(addSheep(100, 500));
			sheeps.push(addSheep(400, 500));
			sheeps.push(addSheep(600, 500));
			sheeps.push(addSheep(200, 500));
			
			TRegistry.instance.setValue("stage", stage);
			
			TRegistry.instance.setValue("sheeps", sheeps);
			
			ufo = new UFO();
			ufo.x = stage.stageWidth / 2;
			ufo.y = stage.stageHeight / 2;
			
			stage.addChild(ufo);
			
			tank = new Tank();
			tank.x = stage.stageWidth / 2;
			tank.y = 500;
			
			stage.addChild(tank);
		}
		
		private function addSheep(x: int, y: int) : Sheep
		{
			var s:Sheep;
			
			s = new Sheep();
			s.x = x;
			s.y = y;
			stage.addChild(s);
			
			return s;
		}
	}
}