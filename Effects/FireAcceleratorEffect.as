package Effects 
{
	import Weapons.BaseWeapon;
	/**
	 * ...
	 * @author Taymir
	 */
	public class FireAcceleratorEffect extends TemporaryEffect 
	{
		private var weapon:BaseWeapon;
		
		public function FireAcceleratorEffect(duration) 
		{
			super(duration);
			
		}
		
		override public function beginEffect(targetObject:ControllableObject):void 
		{
			// Увеличение скорости стрельбы
			// сохраняем в переменной ссылку на изменяемое оружие, т.к. за время
			// действия игрок может сменить оружие на другое
			this.weapon = targetObject.primaryWeapon;
			this.weapon.changeFireDelayPeriod(2.0);
			
			super.beginEffect(targetObject);
		}
		
		override protected function endEffect():void 
		{
			// Уменьшение скорости стрельбы
			this.weapon.changeFireDelayPeriod(0.5);
			
			super.endEffect();
		}
	}

}