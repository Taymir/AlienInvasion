package tests 
{
	import common.TList.TList;
	import common.TList.TListIterator;
	/**
	 * ...
	 * @author Taymir
	 */
	public class TestTList
	{
		
		public function TestTList() 
		{
			
		}
		
		/*
		 * Test cases for:
		 * TList: Add, Count, ToArray
		 * TListIterator: AddItemBefore, AddItemAfter, Next, Prev, IsAtBeggining, IsAtEnd
		 */
		private function test1() : void
		{
			var list: TList = new TList();
			
			list.Add("A");
			list.Add("B");
			list.Add("C");
			list.Add("D");
			list.Add("E");
			list.Add("F");
			
			var iterator:TListIterator = list.Iterator();
			iterator.AddItemBefore("1");
			iterator.Next();
			iterator.AddItemAfter("2");
			
			trace(list.ToArray());
			//1,A,B,2,C,D,E,F
			//+
			
			iterator = list.Iterator(list.Count() - 1);
			iterator.AddItemAfter("3");
			
			iterator = list.Iterator(list.Count() - 1);
			trace(list.ToArray());
			//1,A,B,2,C,D,E,F,3
			//+
			
			while (!iterator.isAtBeginning())
			{
				trace(iterator.CurrentItem());
				iterator.Prev();
			}
			/*
			    3
				F
				E
				D
				C
				2
				B
				A
				1
			*/
			//+
		}
		
		/*
		 * Test cases for:
		 * TList: AddRange, Contains, IndexOf, Remove, RemoveAt, Reset
		 */
		private function test2() : void
		{
			var arr: Array = new Array("H", "E", "L", "O", ",", " ",
									   "W", "O", "R", "L", "D", "!");
		  
			var lst: TList = new TList();
			
			lst.AddRange(arr);
			trace(lst.ToArray());
			//H,E,L,O,,, ,W,O,R,L,D,!
			//+
			
			trace(lst.IndexOf("!"));
			//11
			//+
			
			lst.Remove("!");
			trace(lst.Contains("!"));
			//false
			//+
			trace(lst.IndexOf("!"));
			//-1
			//+
			
			lst.Remove("Q");
			lst.RemoveAt(3);
			trace(lst.ToArray());
			//H,E,L,,, ,W,O,R,L,D
			//+
			
			lst.RemoveAt(0);
			trace(lst.ToArray());
			//E,L,,, ,W,O,R,L,D
			//+
			
			lst.RemoveAt(8);
			trace(lst.ToArray());
			//E,L,,, ,W,O,R,L
			//+
			
			lst.RemoveAt(99);
			trace(lst.ToArray());
			//E,L,,, ,W,O,R,L
			//+
			
			var iterator:TListIterator = lst.Iterator();
			
			iterator.RemoveItem();
			trace(lst.ToArray());
			//L,,, ,W,O,R,L
			//+
			
			iterator.Next(4);
			iterator.RemoveItem();
			trace(lst.ToArray());
			//L,,, ,O,R,L
			//- почему удаляется W а не O ?
			//L,,, ,W,R,L
			//+ 
			
			iterator.Reset()
			iterator.RemoveItem();
			trace(lst.ToArray());
			//","," ","W","R","L"
			//+
			
			iterator.RemoveItem();
			iterator.RemoveItem();
			iterator.RemoveItem();
			iterator.RemoveItem();
			iterator.RemoveItem();
			iterator.RemoveItem();
			
			trace("пустой массив: ", lst.ToArray());
			//пустой массив:  
			//+
			
			iterator.RemoveItem();
			trace("пустой массив: ", lst.ToArray());
			//пустой массив:  
			//+
			
			iterator.Next(20);
			trace(iterator.isAtBeginning() && iterator.isAtEnd());
			//true
			//+
			
			trace(iterator.CurrentItem());
			//null
			//+
			
			iterator.ReplaceItem("T");
			iterator.Reset();
			lst.RemoveAt(0);
			trace("Пустой массив:", lst.ToArray());
			//Пустой массив: 
			//+
			
			lst.AddRange(new Array("Y", "O", ",", " ", "M", "A", "N"));
			trace(lst.ToArray());
			//Y,O,,, ,M,A,N
			//+
		}
		
		/*
		 * Test cases for:
		 * TList: Walk
		 */
		private function test3() : void
		{
			var lst: TList = new TList();
			lst.AddRange(new Array(10, 15, 18, 31, 30, 22, 32, 33, 34, 35, 36, 39));
			
			trace("Квадрат ", lst.Walk(test3_callback_func), " равен больше 1000");
			//Квадрат  32  равен больше 1000
			//+
			
			for (var it:TListIterator = lst.Iterator(); !it.isAtEnd(); it.Next())
			{
				var number:int = it.CurrentItem() as int;
				
				if (number % 2 == 0)
					trace("Чётное число: ", number);
			}
			/*
				Чётное число:  10
				Чётное число:  18
				Чётное число:  30
				Чётное число:  22
				Чётное число:  32
				Чётное число:  34
				Чётное число:  36
			*/
			//+
			
			for (it = lst.Iterator(lst.Count() - 1); !it.isAtBeginning(); it.Prev())
			{
				number = it.CurrentItem() as int;
				
				if (number % 2 != 0)
					trace("Нечётное число: ", number);
			}
			/*
				Нечётное число:  39
				Нечётное число:  35
				Нечётное число:  33
				Нечётное число:  31
				Нечётное число:  15
			*/
			//+
		}
		
		private function test3_callback_func(item: Object) : int
		{
			arguments;
			var number:int = item as int;
			
			if (number * number > 1000)
				return TList.STOP_WALKING;
			
			return TList.CONTINUE_WALKING;
		}
		 
		public function run() : void
		{
			test1();
			test2();
			test3();
		}
		
	}

}