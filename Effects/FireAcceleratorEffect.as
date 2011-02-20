package Effects 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class FireAcceleratorEffect extends TemporaryEffect 
	{
		
		public function FireAcceleratorEffect(duration) 
		{
			super(duration);
			
		}
		
		override public function beginEffect(targetObject:ControllableObject):void 
		{
			// Увеличение скорости стрельбы
			targetObject.primaryWeapon.changeFireDelayPeriod(2.0);
			
			super.beginEffect(targetObject);
		}
		
		override protected function endEffect():void 
		{
			// Уменьшение скорости стрельбы
			targetObject.primaryWeapon.changeFireDelayPeriod(0.5);
			
			super.endEffect();
		}
	}

}