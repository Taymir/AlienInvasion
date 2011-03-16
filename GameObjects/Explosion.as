package GameObjects
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class Explosion extends GameObject
	{
		
		public function Explosion(x: int, y: int) : void
		{
			this.x = x;
			this.y = y;
			
			this.startExplosionAnimation();
			super();
		}
		
		private function startExplosionAnimation() : void
		{
			this.addFrameScript(this.totalFrames - 1, stopExplosionAnimation);
			this.play();
		}
		
		private function stopExplosionAnimation() : void 
		{
			this.stop();
			this.hide();
		}
		
	}

}