package common 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class Debug
	{
		public static function assert(condition:Boolean, message:String)
		{
			if (condition != true)
			{
				var output:String = "****************************\n "
				+ "ASSERT FAILED!!\n " + message + "\n"
				+ "****************************\n ";
				
				trace(output);
			}
		}
	}

}