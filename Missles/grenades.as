package Missles 
{
	import GameObjects.Explosion;
	import GameObjects.ControllableObject;
	import common.TList.TList;
	import common.TRegistry;
	/**
	 * ...
	 * @author Taymir
	 */
	public final class grenades extends BaseMissle
	{
		private const explosionWaveRadius = 200;
		
		public function grenades(x:Number, y:Number, direction:int) 
		{
			super(x, y, direction);
			
			this.speed = 20;
			this.damage = 10;
		}
		
		protected override function hitGround()
		{
			TRegistry.instance.getValue("player").Walk(tank_explosion_wave_collision_detection);
			super.hitGround();
		}
		
		private function tank_explosion_wave_collision_detection(obj: Object) : int
		{
			var targetObj: ControllableObject = obj as ControllableObject;
			
			if (Math.abs(targetObj.x - targetObj.width / 2 - this.x) <= explosionWaveRadius)
			{
				// Отображаем взрыв на танке
				if (targetObj.x < this.x)
					// Удар по правому боку танка
					new Explosion(targetObj.x + targetObj.width / 2, targetObj.y);
				else
					// Удар по правому боку танка
					new Explosion(targetObj.x - targetObj.width / 2, targetObj.y);
				
				// Наносим повреждение танку
				targetObj.hit(damage);
			}
			
			return TList.CONTINUE_WALKING;
		}
		
	}

}