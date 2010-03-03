package org.fatlib.utils
{
	import flash.geom.Point;

	/**
	 * Provides math-related helper methods
	 */
	public class MathUtils 
	{
		
		/**
		 * Flips a coin
		 * 
		 * @return	Whether the outcome was Heads
		 */
		public static function flipCoin():Boolean
		{
			return (Math.random()<0.5)
		}
		
		/**
		 * Rolls some dice 
		 * 
		 * @param	sides	The number of sides on the dice
		 * @param	throws	The number of dice to roll
		 * @return	The total value of the rolled dice
		 */
		public static function rollDice(sides:int=6, throws:int=1):int
		{
			var sum:int = 0;
			for (var i:int = 1; i <= throws;i++ ) sum += (int(Math.random() * sides) + 1);
			return sum;
		}

		/**
		 * Checks whether a number is even
		 * 
		 * @param	x	The number to check
		 * @return	Whether the number is even
		 */
		public static function isEven(x:int):Boolean
		{
			return x % 2 == 0;
		}
		
		
		/**
		 * Checks whether a number is odd
		 * 
		 * @param	x	The number to check
		 * @return	Whether the number is odd
		 */
		public static function isOdd(x:int):Boolean
		{
			return !isEven(x);
		}
		
		/**
		 * Finds the Manhattan distance between 2 points
		 * 
		 * @param	x1	Point 1 x-pos
		 * @param	y1	Point 1 y-pos
		 * @param	x2	Point 2 x-pos
		 * @param	y2	Point 2 y-pos
		 * @return	The Manhattan distance between the 2 points
		 */
		public static function manhattan(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			return Math.abs(x1 - x2) + Math.abs(y1 - y2);
		}
	
		
		/**
		 * Determines whether two ranges overlap. 
		 * 
		 * @param	a0	min of first range
		 * @param	a1	max of first range
		 * @param	b0	min of second range
		 * @param	b1	max of second range
		 * @return	Whether the ranges overlap
		 */
		public static function rangesOverlap(a0:Number, a1:Number, b0:Number, b1:Number):Boolean
		{
			if (a1 < a0)
			{
				var temp:Number = a1;
				a1 = a0;
				a0 = temp;
			}
			
			if (b1 < b0)
			{
				temp = b1;
				b1 = b0;
				b0 = temp;
			}
			
			return (a1 > b0 && a0 < b1);
		}
		
		
		/**
		 * 
		 * Calculates the location of a two-dimensional cubic Bezier curve for a specific parameter
		 * 
		 * @param	p0	The first point of the bezier curve
		 * @param	p1	The second point of the bezier curve
		 * @param	p2	The third point of the bezier curve
		 * @param	p3	The fourth point of the bezier curve
		 * @param	parameter	The parameter, expressed as the fraction of progress along the curve
		 * @return	A point containing the x and y coords of the Bezier curve at the specified parameter
		 */
		public static function getBezierValue(p0:Point, p1:Point, p2:Point, p3:Point, parameter:Number):Point
		{
			var t:Number = parameter;
			var comp0:Point = new Point((1 - t) * (1 - t) * (1 - t) * p0.x, (1 - t) * (1 - t) * (1 - t) * p0.y);
			var comp1:Point = new Point(3 * (1 - t) * (1 - t) * t * p1.x, 3 * (1 - t) * (1 - t) * t * p1.y);
			var comp2:Point = new Point(3 * (1 - t) * t * t * p2.x, 3 * (1 - t) * t * t * p2.y);
			var comp3:Point = new Point(t * t * t * p3.x, t * t * t * p3.y);
			return new Point(comp0.x + comp1.x + comp2.x + comp3.x, comp0.y + comp1.y + comp2.y + comp3.y);
		}
	
		
	}
	
}
