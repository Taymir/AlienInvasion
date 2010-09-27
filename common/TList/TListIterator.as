package common.TList 
{
	/**
	 * Итератор по двунаправленному списку
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
			
			Next(offset);
		}
		
		/*         Методы для перемещения итератора по списку        */
		
		private function hasNext() : Boolean
		{
			if (curNode != null && curNode.next != null)
				return true;
			return false;
		}
		
		/*
		 * Сдвиг итератора вперед на offset позиций
		 */
		public function Next(offset: int = 1) : Object
		{
			for (var i: int = 0; i < offset; i++)
			{
				if (hasNext())
					curNode = curNode.next;
			}
			
			return CurrentItem();
		}
		
		private function hasPrev() : Boolean
		{
			if (curNode != null && curNode.prev != null)
				return true;
			return false;
		}
		
		/*
		 * Сдвиг итератора назад на offset позиций
		 */
		public function Prev(offset: int = 1) : Object
		{
			for (var i: int = 0; i < offset; i++)
			{
				if (hasPrev())
					curNode = curNode.prev;
			}
			
			return CurrentItem();
		}
		
		/*
		 * Возврат итератора к начальной позиции
		 */
		public function Reset() : Object
		{
			this.curNode = list.Begin();
			
			return CurrentItem();
		}
		
		/*
		 * Возвращает true если итератор в конце списка
		 */
		public function isAtEnd() : Boolean
		{
			if (CurrentItem() == list.End())
				return true;
			return false;
		}
		
		/*
		 * Возвращает true если итератор в начале списка
		 */
		public function isAtBeginning() : Boolean
		{
			if (CurrentItem() == list.Begin())
				return true;
			return false;
		}
	
		/*           Методы для работы с текущей нодой         */
		
		/*
		 * Получение текущего элемента
		 */
		public function CurrentItem() : Object
		{
			if (curNode != null)
				return curNode.data;
			return null;
		}
		
		/*
		 * Удаление текущего элемента
		 */
		public function RemoveItem() : void
		{
			curNode = list.RemoveNode(curNode);
		}
		
		/* 
		 * Замена текущего элемента на newItem
		 */
		public function ReplaceItem(newItem : Object) : void
		{
			if (curNode != null)
				curNode.data = newItem;
		}
		
		/*
		 * Добавление элемента newItem перед текущим
		 */
		public function AddItemBefore(newItem: Object) : void
		{
			var newNode: TListNode = new TListNode();
			newNode.data = newItem;
			
			list.AddNodeBefore(curNode, newNode);
		}
		
		/*
		 * Добавление элемента newItem после текущего
		 */
		public function AddItemAfter(newItem: Object) : void
		{
			var newNode: TListNode = new TListNode();
			newNode.data = newItem;
			
			list.AddNodeAfter(curNode, newNode);
		}
	}

}