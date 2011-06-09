package UI 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Taymir
	 */
	public class ProtectionIcon extends UIIcon 
	{
		private const protection_offset: int = 360;
		private const protection_glow: uint = 0x3333DD;
		
		public function ProtectionIcon(name: String, position: int, tooltip: String, action: Function)
		{
			this.type = "protection";
			this._x_offset = protection_offset;
			this._light_up_color = protection_glow;
			super(name, position, tooltip, action);
		}
		
	}

}