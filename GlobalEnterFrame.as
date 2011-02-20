package  
{
	import common.TRegistry;
	import common.TList.TList;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class GlobalEnterFrame
	{
		private var updateMethods:TList;
		
		// Для подсчета FPS
		private var startTime: Number;
		private var framesNumber: Number = 0;
		
		public function GlobalEnterFrame() 
		{
			this.updateMethods = new TList();
			
			startTime = getTimer();
		}
		
		public function Add(func:Function) 
		{			
			this.updateMethods.Add(func);
		}
		
		public function Update(e:Event)
		{
			this.updateMethods.Walk(UpdateIteration);
			
			this.updateFps();
		}
		
		private function updateFps()
		{
			var currentTime: Number = (getTimer() - startTime) / 1000;
			
			framesNumber++;
			
			if (currentTime > 1)
			{
				// Update UI
				var fps: Number = Math.floor( (framesNumber / currentTime) * 10.0 ) / 10.0;
				(TRegistry.instance.getValue("UI") as UserInterfaceManager).setFps(fps);
				
				startTime = getTimer();
				framesNumber = 0;
			}
		}
		
		private function UpdateIteration(obj:Object)
		{
			var func:Function = obj as Function;
			func.call();
		}
		
		public function Remove(func:Function)
		{
			updateMethods.Remove(func);
		}
		
		public function RemoveAll()
		{
			updateMethods.Clear();
		}
		
	}

}