package org.fatlib.game.behaviors
{
	import org.fatlib.game.Entity;
	import org.fatlib.game.EntityBehavior;
	import org.fatlib.ui.Key;
	import org.fatlib.utils.MathUtils;
	
	public class FollowBehavior extends EntityBehavior
	{
		private var _target:Entity;
		private var _halflife:Number = 2;
		
		public function FollowBehavior(target:Entity) 
		{
			super();
			_target = target;
		}
		
		override protected function handleGameUpdate(timeStep:Number = 1):void 
		{
			super.handleGameUpdate(timeStep);
			
			entity.x += (target.x - entity.x) / 5;
			entity.y += (target.y - entity.y) / 5;
			
			if (Key.space) target = target.next;
		}
		
		public function get target():Entity { return _target; }
		
		public function set target(value:Entity):void 
		{
			_target = value;
		}
		
	}

}