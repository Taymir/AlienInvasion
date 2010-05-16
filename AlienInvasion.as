package {
	import flash.display.MovieClip;
	import flash.events.*; 
	import flash.ui.*;
	
	/* Пользовательские библиотеки */
	import Point;
	import Missle;

	public class AlienInvasion extends MovieClip {
		private var nlo:Nlo;
		private var key_pressed = 0;
		
		public function AlienInvasion() {
			nlo = new Nlo();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUpHandler);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			stage.addChild(nlo);
		}

		private function KeyDownHandler(e:KeyboardEvent):void {
			key_pressed = e.keyCode;
			trace(e.keyCode);
		}
		
		private function KeyUpHandler(e:KeyboardEvent):void {
			if (key_pressed == e.keyCode) {
				key_pressed = 0;
			}
		}
		
		private function onEnterFrameHandler(e:Event):void {
			if (this.key_pressed == 87) {
				this.nlo.y -= 5; 
			}
			
			if (this.key_pressed == 83) {
				this.nlo.y += 5;
			}
			
			if (this.key_pressed == 65) {
				this.nlo.x -= 5;
			}
			
			if (this.key_pressed == 68) {
				this.nlo.x += 5;
			}
			
			if (this.key_pressed == 32) {
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