package Effects 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class SpeedAcceleratorEffect extends TemporaryEffect 
	{
		
		public function SpeedAcceleratorEffect(duration = 5000) 
		{
			super(duration);
		}
		
		override public function beginEffect(targetObject:ControllableObject):void 
		{
			// Увеличение скорости перемещения
			targetObject.maxspeed += 7;
			
			super.beginEffect(targetObject);
		}
		
		override protected function endEffect():void 
		{
			// Уменьшение скорости перемещения
			targetObject.maxspeed -= 7;
			
			super.endEffect();
		}
		
	}

}