package tests 
{
	import common.MathExtra;
	import common.TList.TList;
	import common.TList.TListIterator;
	/**
	 * ...
	 * @author Taymir
	 */
	public class testListArrayVector 
	{
		private static const LENGTH:int = 100*1000;
		
		public function testListArrayVector() 
		{
			
		}
		
		private function generateVector():Vector.<Number>
		{
			var v:Vector.<Number> = new Vector.<Number>(LENGTH, true);

			for(var i:int = 0; i < LENGTH; i++)
			{
				v[i] = Math.random() * 100000;
			}

			return v;
		}

		private function averageVector(v:Vector.<Number>):Number
		{
			var sum:Number = 0;
			var len:int = v.length;

			for(var i:int = 0; i < LENGTH; i++)
			{
				sum += v[i];
			}

			return (sum / len);
		}
		
		private function randomReadVector(v: Vector.<Number>): Number
		{
			var sum: Number = 0;
			
			for (var i:int = 0; i < LENGTH; i++)
			{
				sum += v[MathExtra.RandomInt(0, LENGTH)];
			}
			
			return sum;
		}
		
		private function randomWriteVector(v: Vector.<Number>): Vector.<Number>
		{			
			/*for (var i:int = 0; i < LENGTH; i++)
			{
				v.splice(MathExtra.RandomInt(0, LENGTH), 0, Math.random() * 100000);
			}*/
			
			return v;
		}
		
		private function generateArray():Array
		{
			var a:Array = new Array(LENGTH);

			for(var i:int = 0; i < LENGTH; i++)
			{
				a[i] = Math.random() * 100000;
			}

			return a;
		}

		private function averageArray(arr:Array):Number
		{
			var sum:Number = 0;
			var len:int = arr.length;

			for(var i:int = 0; i < LENGTH; i++)
			{
				sum += arr[i];
			}

			return (sum / len);
		}
		
		private function randomReadArray(arr: Array):Number
		{
			var sum: Number = 0;
			
			for(var i:int = 0; i < LENGTH; i++)
			{
				sum += arr[MathExtra.RandomInt(0, LENGTH)];
			}
			
			return sum;
		}
		
		private function randomWriteArray(arr: Array): Array
		{			
			for (var i:int = 0; i < LENGTH; i++)
			{
				arr.splice(MathExtra.RandomInt(0, LENGTH), 0, Math.random() * 100000);
			}
			
			return arr;
		}
		
		private function generateList() : TList
		{
			var l: TList = new TList();
			
			for (var i: int = 0; i < LENGTH; i++)
			{
				l.Add(Math.random() * 100000);
			}
			
			return l;
		}
		
		private function averageList(lst: TList) : Number
		{
			var sum: Number = 0;
			var len:int = lst.Count();
			
			for (var it:TListIterator = lst.Iterator(); !it.isAtEnd(); it.Next())
			{
				var number:int = it.CurrentItem() as int;
				
				sum += number;
			}
			
			return (sum / len);
		}
		
		private function randomReadList(lst: TList):Number
		{
			var sum: Number = 0;
			
			for(var i:int = 0; i < LENGTH; i++)
			{
				sum += lst.Get(MathExtra.RandomInt(0, LENGTH));
			}
			
			return sum;
		}
		
		private function randomWriteList(lst: TList): TList
		{			
			/*for (var i:int = 0; i < LENGTH; i++)
			{
				arr.splice(MathExtra.RandomInt(0, LENGTH), 0, Math.random() * 100000);
				lst.
			}
			*/
			return lst;
			//NO SIMPLE WAY TO IMPLEMENT???
		}

		private function getTime():Number
		{
			return (new Date()).getTime();
		}
		
		private function test_sequential_write()
		{
			trace("SEQUENTIAL WRITE");
			
			// VECTOR
			var vecStartTime: Number = getTime();
			
			var v: Vector.<Number> = generateVector();
			
			var vecTime: Number = (getTime() - vecStartTime) / 1000;
			
			// ARRAY
			var arrStartTime: Number = getTime();
			
			var a: Array = generateArray();
			
			var arrTime: Number = (getTime() - arrStartTime) / 1000;
			
			// LIST
			var lstStartTime: Number = getTime();
			var l: TList = generateList();
			
			var lstTime: Number = (getTime() - lstStartTime) / 1000;
			
			//OUTPUT RESULTS
			trace("Vector", vecTime);
			trace("Array", arrTime);
			trace("List", lstTime);
		}
		
		private function test_sequential_read()
		{
			trace("SEQUENTIAL READ");
			
			// VECTOR
			var vecStartTime: Number = getTime();
			
			var v: Vector.<Number> = generateVector();
			var vAvg:Number = averageVector(v);
			
			var vecTime: Number = (getTime() - vecStartTime) / 1000;
			
			// ARRAY
			var arrStartTime: Number = getTime();
			
			var a: Array = generateArray();
			var aAvg: Number = averageArray(a);
			
			var arrTime: Number = (getTime() - arrStartTime) / 1000;
			
			// LIST
			var lstStartTime: Number = getTime();
			var l: TList = generateList();
			var lAvg: Number = averageList(l);
			
			var lstTime: Number = (getTime() - lstStartTime) / 1000;
			
			//OUTPUT RESULTS
			trace("Vector", vecTime);
			trace("Array", arrTime);
			trace("List", lstTime);
		}
		
		private function test_random_read()
		{
			trace("RANDOM READ");
			
			// VECTOR
			var vecStartTime: Number = getTime();
			
			var v: Vector.<Number> = generateVector();
			randomReadVector(v);
			
			var vecTime: Number = (getTime() - vecStartTime) / 1000;
			
			// ARRAY
			var arrStartTime: Number = getTime();
			
			var a: Array = generateArray();
			randomReadArray(a);
			
			var arrTime: Number = (getTime() - arrStartTime) / 1000;
			
			// LIST
			var lstStartTime: Number = getTime();
			var l: TList = generateList();
			randomReadList(l);
			
			var lstTime: Number = (getTime() - lstStartTime) / 1000;
			
			//OUTPUT RESULTS
			trace("Vector", vecTime);
			trace("Array", arrTime);
			trace("List", lstTime);
		}
		
		private function test_random_write()
		{
			trace("RANDOM WRITE");
			
			// VECTOR
			var vecStartTime: Number = getTime();
			
			var v: Vector.<Number> = generateVector();
			randomWriteVector(v);
			
			var vecTime: Number = (getTime() - vecStartTime) / 1000;
			
			// ARRAY
			var arrStartTime: Number = getTime();
			
			var a: Array = generateArray();
			randomWriteArray(a);
			
			var arrTime: Number = (getTime() - arrStartTime) / 1000;
			
			
			//OUTPUT RESULTS
			trace("Vector", "n/a");
			trace("Array", arrTime);
			trace("List", "n/a");
		}
		
		public function run()
		{
			test_sequential_write();
			test_sequential_read();
			//test_random_read();//TOOO LONG!
			test_random_write();
			////RESULTS
			/*
			SEQUENTIAL WRITE
			Vector 0.029
			Array 0.021
			List 0.119
			SEQUENTIAL READ
			Vector 0.02
			Array 0.04
			List 0.214
			RANDOM WRITE
			Vector n/a
			Array 3.951
			List n/a

			*/
		}
		
	}

}