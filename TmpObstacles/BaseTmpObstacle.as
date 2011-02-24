package TmpObstacles 
{
	import common.TList.TList;
	import common.TRegistry;
	import Missles.BaseMissle;
	/**
	 * ...
	 * @author Taymir
	 */
	public class BaseTmpObstacle extends GameObject
	{
		protected var shooterObj: ControllableObject;
		
		public function BaseTmpObstacle(shooterObj: ControllableObject) 
		{
			this.shooterObj = shooterObj;
			
			addToList("tmp_obstacles");
			addToGlobalEnterFrame(update);
			super();
			update();
		}
		
		protected function update()
		{
			this.x = shooterObj.x;
			this.y = shooterObj.y;
		}
		
		public override function dispose() : void
		{
			removeFromList("tmp_obstacles");
			removeFromGlobalEnterFrame(update);
			super.dispose();
		}
		
		public function handleMissle(missle: BaseMissle)
		{
			//@EMPTY
		}
	}

}