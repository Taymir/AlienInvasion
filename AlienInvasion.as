package {
	import flash.display.MovieClip;
	import flash.events.*; 
	import flash.ui.*;
	
	/* Пользовательские библиотеки */
	import Missle;

	public class AlienInvasion extends MovieClip {
		private var ufo:UFO;
		private var key_pressed = 0;
		
		public function AlienInvasion() {
			ufo = new UFO();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUpHandler);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			stage.addChild(ufo);
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
				this.ufo.y -= 5; 
			}
			
			if (this.key_pressed == 83) {
				this.ufo.y += 5;
			}
			
			if (this.key_pressed == 65) {
				this.ufo.x -= 5;
			}
			
			if (this.key_pressed == 68) {
				this.ufo.x += 5;
			}
			
			if (this.key_pressed == 32) {
				// test fire
				/*var missle:MovieClip = new MissleSprite();
				
				missle.x = point.x;
				missle.y = point.y;
				
				stage.addChild(missle);
				
				while(missle.y <= stage.stageHeight) {
					missle.y += 1;
				}
				
				stage.removeChild(missle); // Уничтожаем ракету
				*/
			}
		}
	}
}