package Missles 
{
	import Effects.FreezeEffect;
	/**
	 * ...
	 * @author Taymir
	 */
	public final class paralyze_bomb extends BaseMissle 
	{
		
		public function paralyze_bomb(x:Number, y:Number, direction:int) 
		{
			this.speed = 12;
			this.damage = 0;
			super(x, y, direction);
		}
		
		protected override function hitTarget(targetObj: ControllableObject)
		{
			//this.Explode();
			//tarjetObj.hit(damage);
			targetObj.applyEffect(new FreezeEffect(5000));
		}
		
	}

}