package common 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class TListIterator
	{
		private var list: TList;
		private var curNode: TListNode;
		
		public function TListIterator(list: TList, offset: int = 0) 
		{
			this.list = list;
			this.Reset();
			
			
		}
		
		// Методы для перемещения итератора по списку
		public function hasNext() : Boolean
		{
			if (curNode != null && curNode.next != null)
				return true;
			return false;
		}
		
		public function Next(offset: int = 1) : Object
		{
			for (var i: int = 0; i < offset; i++)
			{
				if (hasNext())
					curNode = curNode.next;
			}
			
			return CurrentItem();
		}
		
		public function Reset() : Object
		{
			this.curNode = list.Begin();
			
			return CurrentItem();
		}
	
		// Методы для работы с текущей нодой
		public function CurrentItem() : Object
		{
			if (curNode != null)
				return curNode.data;
			return null;
		}
		
		public function RemoveItem() : void
		{
			
		}
		
		public function ReplaceItem(newItem : Object) : void
		{
			if (curNode != null)
				curNode.data = newItem;
		}
		
		public function AddBefore(newItem: Object) : void
		{
			
		}
		
		public function AddAfter(newItem: Object) : void
		{
			
		}
	}

}