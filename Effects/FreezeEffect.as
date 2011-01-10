package Effects 
{
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Taymir
	 */
	public class FreezeEffect extends TemporaryEffect
	{	
		public var speedReduction: Number = 0.5;
		
		public function FreezeEffect(duration: int)
		{
			super(duration);
		}
		
		override public function beginEffect(targetObject:ControllableObject) : void 
		{
			// Изменение скорости
			targetObject.maxspeed *= speedReduction;
			
			// Изменение цвета
			var colTransf:ColorTransform = targetObject.transform.colorTransform;
			colTransf.blueMultiplier = 1.5;
			colTransf.redMultiplier = 0.8;
			colTransf.greenMultiplier = 0.8;
			targetObject.transform.colorTransform = colTransf;

			super.beginEffect(targetObject);
		}
		
		override protected function endEffect() : void
		{
			//Восстановление скорости
			targetObject.maxspeed /= speedReduction;
			
			// Восстановление цвета
			var colTransf:ColorTransform = targetObject.transform.colorTransform;
			colTransf.blueMultiplier = 1;
			colTransf.redMultiplier = 1;
			colTransf.greenMultiplier = 1;
			targetObject.transform.colorTransform = colTransf;
			//@BUG: когда freezeEffect прошел, цвет восстанавливается. Но если при этом было наложено
			// несколько freezeEffect-ов, то цвет восстанавливается раньше, чем все эффекты сойдут на нет.
			// Решения:
			// 1) Проверять на полное восстановление скорости
			// 2) Вести список наложенных эффектов и проверять на то, наложены ли ещё подобные эффекты
			// 3) Просто не давать возможности врагам стрелять часто энергопотоками (таким образом, эффект устранится
			// раньше, чем сможет быть наложен новый
			//
			// Пока выбрано решение 3.
			
			super.endEffect();
		}
	}

}