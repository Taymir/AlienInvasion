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
		
		public function ParticleSparkles(x: int, y: int) : void
		{
			this.startExplosionAnimation(x, y, 15, 30, 2.0, 75);
		}
		
		private function startExplosionAnimation(x: int, y:int,
			particlesCount: int, distance: Number,
			size: Number, alpha: Number) : void
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