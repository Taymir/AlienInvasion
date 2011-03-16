package UI 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Taymir
	 */
	public class WeaponIcon extends UIIcon 
	{
		private const weapons_offset: int = 156;
		private const weapon_glow: uint = 0xDD3333;
		
		public function WeaponIcon(name:String, position:int, action: Function) 
		{
			this._x_offset = weapons_offset;
			this._light_up_color = weapon_glow;
			super(name, position, action);
		}
		
	}

}