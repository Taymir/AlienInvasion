package Missles 
{
	import common.TList.TList;
	import common.TRegistry;
	/**
	 * ...
	 * @author Taymir
	 */
	//@TODO: Добавить повреждение не только  при прямом попадании
	public final class grenades extends BaseMissle
	{
		private const explosionWaveRadius = 70;
		
		public function grenades(x:Number, y:Number, direction:int) 
		{
			super(x, y, direction);
			
			this.speed = 20;
			this.damage = 10;
		}
		
		protected override function groundExplosion()
		{
			TRegistry.instance.getValue("player").Walk(tank_explosion_wave_collision_detection);
			super.groundExplosion();
		}
		
		private function tank_explosion_wave_collision_detection(obj: Object) : int
		{
			var targetObj: ControllableObject = obj as ControllableObject;
			
			if (Math.abs(targetObj.x - targetObj.width / 2 - this.x) <= explosionWaveRadius)
			{
				//@TODO: не работает, т.к. stopExplosion обрабатывает другой взрыв...
				// Отображаем взрыв на танке
				/*explosion = new Explosion();//@REFACTOR: вынести все настройки взрыва в класс взрыва
				
				if (targetObj.x < this.x)
				{
					// Удар по правому боку танка
					explosion.x = targetObj.x + targetObj.width / 2;
					explosion.y = targetObj.y;
				} else {
					// Удар по правому боку танка
					explosion.x = targetObj.x - targetObj.width / 2;
					explosion.y = targetObj.y;
				}
				
				// Проигрываем анимацию взрыва
				explosion.addFrameScript(explosion.totalFrames - 1, stopExplosion);
				scene.addChild(explosion);*/
				
				// Наносим повреждение танку
				targetObj.hit(damage);
			}
			
			return TList.CONTINUE_WALKING;
		}
		
	}

}