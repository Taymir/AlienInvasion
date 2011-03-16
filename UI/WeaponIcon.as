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
		
		public function WeaponIcon(name:String, position:int, action: Function) 
		{
			this._x_offset = weapons_offset;
			super(name, position, action);
		}
		
	}

}