package common.TList 
{
	/**
	 * Двунаправленный список
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
		
		
		
		/*                 ВНУТРЕННИЕ МЕТОДЫ             */
		
		/*
		 * Добавление объекта в конец списка
		 */
		private function Push(obj: Object) : void
		{
			var node: TListNode = new TListNode();
			
			node.data = obj;
			node.next = null;
			node.prev = null;
			
			if (lastNode == null)
			{
				// Если последней ноды нет (т.е. список пуст)
				// Делаем новую ноду первой и последней
				node.prev = null;
				rootNode = node;
				lastNode = node;
			} else {
				// Если последняя нода есть, (т.е. список содержит один или более элементов)
				// Делаем новую ноду последней
				node.prev = lastNode;
				lastNode.next = node;
				lastNode = node;
			}
			
			size++;
		}
		
		/*
		 * Удаление последнего элемента из списка
		 */
		private function Pop() : void
		{
			// Если список не пуст
			if (lastNode != null)
			{
				// Получение предпоследнего элемента
				var prevNode:TListNode = lastNode.prev;
				
				// Удаление последнего элемента
				prevNode.next = null;
				lastNode = prevNode;
				
				size--;
			}
		}
		
		
		
		/*                 ПОЛЬЗОВАТЕЛЬСКИЕ МЕТОДЫ             */
		
		/*
		 * Получение нового итератора
		 */
		public function Iterator(offset: int = 0) : TListIterator
		{
			return new TListIterator(this, offset);
		}
		
		/*
		 * Добавление элемента в список
		 */
		public function Add(obj: Object) : void
		{
			Push(obj);
		}
		
		/*
		 * Добавление массива элементов в список
		 */
		public function AddRange(arr: Array) : void
		{
			for (var i : int; i < arr.length; i++)
			{
				Push(arr[i]);
			}
		}
		
		/*
		 * Возврат размера списка
		 */
		public function Count() : int
		{
			return this.size;
		}
		
		/*
		 * Преобразование списка в массив
		 */
		public function ToArray() : Array
		{
			var arr = new Array(size);
			var arr_iterator: int = 0;
			var lst_iterator:TListIterator = this.Iterator();
			
			// Перебираем список
			while (!lst_iterator.isAtEnd())
			{
				// Добавляем текущий элемент в массив
				arr[arr_iterator] = lst_iterator.CurrentItem();
				
				arr_iterator++;
				lst_iterator.Next();
			}
			
			return arr;
		}
		
		/*
		 * Проверка пустоты списка
		 */
		public function isEmpty() : Boolean
		{
			return (size == 0);
		}
		
		/*
		 * Удаление всех элементов списка
		 */
		public function Clear() : void
		{
			this.size = 0;
			this.rootNode = null;
			this.lastNode = null;
		}
		
		/*
		 * Проверка на наличие объекта obj в списке
		 */
		public function Contains(obj: Object) : Boolean
		{
			// Перебираем список
			for (var it:TListIterator = this.Iterator(); !it.isAtEnd(); it.Next())
			{
				// Если элемент найден, выходим
				if (it.CurrentItem() == obj)
					return true;
			}
			
			// Элемент не найден - возвращаем false
			return false;
		}
		
		/*
		 * Получение индекса искомого объекта obj
		 */
		public function IndexOf(obj: Object) : int
		{
			var it:TListIterator = this.Iterator();
			var index: int = 0;
			
			// Перебираем список
			while (!it.isAtEnd())
			{
				// Если элемент найден, возвращаем его индекс
				if (it.CurrentItem() == obj)
					return index;
				
				index++;
				it.Next();
			}
			
			// Элемент не найден, возвращаем -1
			return -1;
		}
		
		/*
		 * Удаление заданного объекта
		 */
		public function Remove(obj: Object): void
		{
			// Перебираем список
			for (var it:TListIterator = this.Iterator(); !it.isAtEnd(); it.Next())
			{
				// Если элемент найден, удаляем его и выходим
				if (it.CurrentItem() == obj)
				{
					it.RemoveItem();
					return;
				}
			}
		}
		
		/*
		 * Удаление элемента под индексом номер offset
		 */
		public function RemoveAt(offset: int): void
		{
			var it:TListIterator = this.Iterator(offset);
			
			it.RemoveItem();
		}
		
		/*
		 * Применяет пользовательскую функцию func к каждому элементу списка
		 * func(Object): Boolean - принимает элемент списка, 
		 * возвращает false для остановки перебора, true для продолжения
		 */
		public function Walk(func:Function) : void
		{
			const stop_walking = 0;
			
			var it:TListIterator = this.Iterator();
			var index: int = 0;
			
			// Перебираем список
			while (!it.isAtEnd())
			{
				// Применяем функцию к текущему элементу
				if (func.call(it.CurrentItem()) == stop_walking)
					return;
				
				index++;
				it.Next();
			}
		}
		
		
		
		
		
		/*              РАБОТА С НОДАМИ (ДЛЯ ИТЕРАТОРА)                   */
		
		/*
		 * Ссылка на начало списка
		 */
		public function Begin() : TListNode
		{
			return rootNode;
		}
		
		/*
		 * Ссылка на конец списка
		 */
		public function End() : TListNode
		{
			return null;
		}
		
		/*
		 * Удаление ноды
		 */
		public function RemoveNode(curNode: TListNode) : TListNode
		{
			if (curNode != null)
			{
				var prevNode: TListNode = curNode.prev;
				var nextNode: TListNode = curNode.next;
				
				// Перепривязываем предыдущую ноду с текущей
				prevNode.next = nextNode;
				nextNode.prev = prevNode;
				curNode = prevNode;
				
				// Уменьшаем размер списка
				size--;
			}
			
			return curNode;
		}
		
		/*
		 * Добавление новой ноды перед текущей нодой
		 */
		public function AddNodeBefore(curNode: TListNode, newNode: TListNode) : TListNode
		{
			if (curNode != null && newNode != null)
			{
				var prevNode: TListNode = curNode.prev;
				
				// Если существует предыдущая нода
				if (prevNode != null)
				{
					prevNode.next = newNode;
					newNode.prev = prevNode;
				} else {
					newNode.prev = null;
				}
				
				newNode.next = curNode;
				curNode.prev = newNode;
				
				size++;
				
				return newNode;
			}
			return curNode;
		}
		
		/*
		 * Добавление новой ноды после текущей ноды
		 */
		public function AddNodeAfter(curNode: TListNode, newNode: TListNode) : TListNode
		{
			if (curNode != null && newNode != null)
			{
				var nextNode: TListNode = curNode.next;
				
				// Если существует следующая нода
				if (nextNode != null)
				{
					nextNode.prev = newNode;
					newNode.next = nextNode;
				} else {
					newNode.next = null;
				}
				
				newNode.prev = curNode;
				curNode.next = newNode;
				
				size++;
				
				return newNode;
			}
			return curNode;
		}
	}

}