package Missles 
{
	import GameObjects.*;
	import TmpEffects.FreezeEffect;
	/**
	 * ...
	 * @author Taymir
	 * Этот класс, как и многие в системе нарушает принцип подстановки Лискоу (LSP): 
	 * Быстрая разработка программ (Роберт К. Мартин), стр. 185
	 * Т.к. он  принципиально изменяет поведение базового класса (энергопотоки перестают взрываться, в отличии от ракет)
	 * так что, логично было бы наследовать его от более абстрактного класса нежели BaseMissle,
	 * но пока это допустимое нарушение
	 */
	public final class freezer extends BaseMissle
	{
		
		public function freezer(x:Number, y:Number, direction:int) 
		{
			this.speed = 12;
			this.damage = 0;
			super(x, y, direction);
		}
		
		protected override function hitGround()
		{
			//this.Explode();// Энергопотоки не взрываются
		}
		
		protected override function hitTarget(targetObj: ControllableObject)
		{
			//this.Explode();// Энергопотоки не взрываются
			//tarjetObj.hit(damage);//Энергопотоки не повреждают танк, вместо этого они накладывают на него эффект заморозки
			targetObj.applyEffect(new FreezeEffect(5000));
		}
	}

}