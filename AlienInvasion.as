package {
	import flash.display.MovieClip;
	import flash.events.*; 
	import flash.ui.*;

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
		}
	}
}