package  
{
	import common.MathExtra;
	import common.TRegistry;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Taymir
	 */
	public class ParticleSparkles 
	{
		protected var particlesCount: int;
		protected var distance: Number;
		protected var size: Number;
		protected var alpha: Number;
		
		public function ParticleSparkles(x: int, y: int, particlesCount:int = 3, distance: Number = 30, size: Number = 1.5, alpha: Number = 60) : void
		{
			this.particlesCount = particlesCount;
			this.distance = distance;
			this.size = size;
			this.alpha = alpha;
			
			this.startSparklesAnimation(x, y);
		}
		
		private function startSparklesAnimation(x: int, y:int) : void
		{
			//run a for loop based on amount of explosion particles
			for (var i = 0; i < particlesCount; i++)
			{
				// create particle
				var particle: MovieClip = new sparkle();
				var particle2:MovieClip = new sparkle2();
				
				// set particle position
				particle.x =  x + MathExtra.RandomInt(0, distance) - (distance / 2);
				particle.y =  y + MathExtra.RandomInt(0, distance) - (distance / 2);
				particle2.x = x + MathExtra.RandomInt(0, distance) - (distance / 2);
				particle2.y = y + MathExtra.RandomInt(0, distance) - (distance / 2);
				
				// get random particle scale
				var tmpSize = MathExtra.RandomInt(0, size)  + size / 2;
				
				// set particle scale
				particle.scaleX = tmpSize;
				particle.scaleY = tmpSize;
				
				// get random particle scale
				tmpSize = MathExtra.RandomInt(0, size) + size / 2;
				
				// set particle scale
				particle2.scaleX = tmpSize;
				particle2.scaleY = tmpSize;
				
				// set particle rotation
				particle2.rotation = MathExtra.RandomInt(0, 359);
				
				// set particle alpha
				particle.alpha  = MathExtra.RandomInt(0, alpha) + alpha / 4;
				particle2.alpha = MathExtra.RandomInt(0, alpha) + alpha / 4;
				
				// show particles
				showParticle(particle);
				showParticle(particle2);
			}
		}
		
		private function getScene() : MovieClip
		{
			return TRegistry.instance.getValue("scene");
		}
		
		private function showParticle(particle: MovieClip) : void
		{
			var scene : MovieClip = this.getScene();
			scene.addChild(particle);
		}
		
	}

}