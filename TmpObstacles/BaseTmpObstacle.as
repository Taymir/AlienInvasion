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
			
			addToTmpObstaclesList();
			addToGlobalEnterFrame(update);
			super();
			update();
		}
		
		protected function addToTmpObstaclesList()
		{
			(TRegistry.instance.getValue("tmp_obstacles") as TList).Add(this);
		}
		
		protected function removeFromTmpObstaclesList()
		{
			(TRegistry.instance.getValue("tmp_obstacles") as TList).Remove(this);
		}
		
		protected function update()
		{
			this.x = shooterObj.x;
			this.y = shooterObj.y;
		}
		
		public override function destroy() : void
		{
			removeFromTmpObstaclesList();
			removeFromGlobalEnterFrame(update);
			super.destroy();
		}
		
		public function handleMissle(missle: BaseMissle)
		{
			//@EMPTY
		}
	}

}