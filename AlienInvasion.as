package {
	import flash.display.MovieClip;
	import flash.events.*; 
	import flash.ui.*;
	
	/* Пользовательские библиотеки */
	import Point;
	import Missle;

	public class AlienInvasion extends MovieClip {
		private var nlo:Nlo;
		
		public function AlienInvasion() {
			nlo = new Nlo();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDownHandler);
			stage.addChild(nlo);
		}

		private function KeyDownHandler(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.UP) {
				this.nlo.y -= 5; 
			}
			
			if (e.keyCode == Keyboard.DOWN) {
				this.nlo.y += 5;
			}
			
			if (e.keyCode == Keyboard.LEFT) {
				this.nlo.x -= 5;
			}
			
			if (e.keyCode == Keyboard.RIGHT) {
				this.nlo.x += 5;
			}
			
			if (e.keyCode == Keyboard.SPACE) {
				// test fire
				var missle:MovieClip = new MissleSprite();
				var point:Point =  getMiddleLocationNlo(this.nlo);
				
				missle.x = point.x;
				missle.y = point.y;
				
				stage.addChild(missle);
				
				while(missle.y <= stage.stageHeight) {
					missle.y += 1;
					trace("Позиция ракеты: x=" + missle.x + "; y=" + missle.y + ";");
				}
				
				stage.removeChild(missle); // Уничтожаем ракету
			}
			
			trace ("Центр нло по X: " + this.getMiddleLocationNlo(this.nlo).x + ". Центр нло по Y: " + this.getMiddleLocationNlo(this.nlo).y);
		}
		
		private function getMiddleLocationNlo(nlo:Nlo):Point {
			return new Point(nlo.x + nlo.width / 2, nlo.y + nlo.height);
		}
	}
}