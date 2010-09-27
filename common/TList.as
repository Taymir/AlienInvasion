package common 
{
	/**
	 * Однонаправленный список
	 * @author Taymir
	 */
	public class TList
	{
		private var rootNode: TListNode;
		private var lastNode: TListNode
		private var size: int;
			
		public function TList() 
		{
			Clear();
		}
		
		// Добавление объекта в конец списка
		private function Push(obj: Object) : void
		{
			var node: TListNode = new TListNode();
			
			node.data = obj;
			node.next = null;
			node.prev = null;
			
			if (lastNode != null)
			{
				node.prev = lastNode;
				lastNode.next = node;
				lastNode = node;
			} else {
				node.prev = null;
				rootNode = node;
				lastNode = node;
			}
			
			size++;
		}
		
		// Алиас для Push
		public function Add(obj: Object) : void
		{
			Push(obj);
		}
		
		// Удаление последнего элемента из списка
		private function Pop() : void
		{
			if (rootNode != null)
			{
				// Если в списке есть только корневой элемент
				if (rootNode.next == null)
				{
					// Удаление корневого элемента
					rootNode = null;
					
					size = 0;
				} else {
					var prevNode: TListNode = rootNode;
					
					// Поиск предпоследнего элемента
					while (prevNode.next != null && prevNode.next != lastNode)
					{
						prevNode = prevNode.next;
					}
					
					// Удаление последнего элемента
					prevNode.next = null;
					lastNode = prevNode;
					
					size--;
				}
			}
		}
		
		// Возврат размера списка
		public function Count() : int
		{
			return this.size;
		}
		
		// Преобразование в массив
		/*public function ToArray() : Array
		{
			var arr = new Array(size);
			
			if (rootNode != null)
			{
				var prevNode: TListNode = rootNode;
				var iterator: int = 0;
				
				// Перебор всех элементов списка
				while (prevNode.next != null && prevNode != lastNode)
				{
					// Добавление элемента в массив
					arr[iterator++] = prevNode.data;
					prevNode = prevNode.next;
				}
			}
			
			return arr;
		}*/
		
		// Удаление всех элементов списка
		public function Clear() : void
		{
			this.size = 0;
			this.rootNode = null;
			this.lastNode = null;
		}
		
		public function Begin() : TListNode
		{
			return rootNode;
		}
		
		public function End() : TListNode
		{
			return null;
		}
		
	}

}