package TmpEffects 
{
	import GameObjects.*;
	import TmpObstacles.energy_umbrella;
	/**
	 * ...
	 * @author Taymir
	 */
	public class EnergyUmbrellaEffect extends TemporaryEffect 
	{
		private var umbrella: energy_umbrella;
		
		public function EnergyUmbrellaEffect(duration = 15000) 
		{
			super(duration);
			
		}
		
		override public function beginEffect(targetObject:ControllableObject):void 
		{
			// Добавление энергетического зонтика
			umbrella = new energy_umbrella(targetObject);
			
			super.beginEffect(targetObject);
		}
		
		override protected function endEffect():void 
		{
			// Удаление энергетического зонтика
			umbrella.dispose();
			umbrella = null;
			
			super.endEffect();
		}
	}

}