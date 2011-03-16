package TmpEffects 
{
	import GameObjects.*;
	import TmpObstacles.metal_shield;
	/**
	 * ...
	 * @author Taymir
	 */
	public class MetalShieldEffect extends TemporaryEffect 
	{
		private var shield: metal_shield;
		
		public function MetalShieldEffect(duration = 15000) 
		{
			super(duration);
			
		}
		
		override public function beginEffect(targetObject:ControllableObject):void 
		{
			// Добавление щита
			shield = new metal_shield(targetObject);
			
			super.beginEffect(targetObject);
		}
		
		override protected function endEffect():void 
		{
			// Удаление щита
			shield.dispose();
			shield = null;
			
			super.endEffect();
		}
		
	}

}