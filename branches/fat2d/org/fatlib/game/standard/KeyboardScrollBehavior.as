package org.fatlib.game.standard
{
	import org.fatlib.game.GameComponent;
	import org.fatlib.ui.Key;
	
	public class KeyboardScrollBehavior extends GameComponent
	{
		private var _stepDistance:Number;
		
		public function KeyboardScrollBehavior(stepDistance:Number = 5) 
		{
			super();
			_stepDistance = stepDistance;
		}
		
		override public function update(timeStep:Number = 1):void 
		{
			var step:Number = _stepDistance * timeStep; 
			if (Key.shift) step *= 2;
			if (Key.up) gameObject.transform.y -= step;
			if (Key.down) gameObject.transform.y += step;
			if (Key.left) gameObject.transform.x -= step;
			if (Key.right) gameObject.transform.x += step;
			
		}
		
	}

}