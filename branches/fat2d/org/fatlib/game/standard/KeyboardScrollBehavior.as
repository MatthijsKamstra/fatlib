package org.fatlib.game.standard
{
	import org.fatlib.game.Behavior;
	import org.fatlib.ui.Key;
	
	public class KeyboardScrollBehavior extends Behavior
	{
		private var _stepDistance:Number=20;
		
		public function KeyboardScrollBehavior() 
		{
			super();
		}
		
		override public function update(timeStep:Number = 1):void 
		{
			if (Key.up) gameObject.transform.y -= _stepDistance * timeStep;
			if (Key.down) gameObject.transform.y += _stepDistance * timeStep;
			if (Key.left) gameObject.transform.x -= _stepDistance * timeStep;
			if (Key.right) gameObject.transform.x += _stepDistance * timeStep;
			
		}
		
	}

}