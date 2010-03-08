package org.fatlib.game.behaviors 
{
	import org.fatlib.game.EntityBehavior;
	import org.fatlib.ui.Key;
	
	public class KeyboardScrollBehavior extends EntityBehavior
	{
		private var _stepDistance:Number=20;
		
		public function KeyboardScrollBehavior() 
		{
			super();
		}
		
		override protected function handleGameUpdate(timeStep:Number = 1):void 
		{
			if (Key.up) entity.y -= _stepDistance * timeStep;
			if (Key.down) entity.y += _stepDistance * timeStep;
			if (Key.left) entity.x -= _stepDistance * timeStep;
			if (Key.right) entity.x += _stepDistance * timeStep;
		}
		
		
	}

}