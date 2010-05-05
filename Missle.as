package {
	import flash.display.MovieClip;
	
	/* Пользовательские библиотеки */
	import Point;
	
	public class Missle extends MovieClip {
		private var sprite:MovieClip;
		
		public function Missle(sprite:MovieClip, location:Point) {
			this.sprite = sprite;
			this.sprite.x = location.x;
			this.sprite.y = location.y;
			stage.addChild(this.sprite);
			this.move();
		}
		
		private function move():void {
			while (this.sprite.y <= stage.height) {
				this.sprate.y += 1;
			}
		}
	}
}