package org.fatlib.game.standard
{
	import org.fatlib.game.Behavior;
	import org.fatlib.game.Entity;
	import org.fatlib.game.EntityBehavior;
	import org.fatlib.game.GameObject;
	import org.fatlib.struct.Component;
	import org.fatlib.ui.Key;
	import org.fatlib.utils.MathUtils;
	
	public class FollowBehavior extends Behavior
	{
		private var _target:Entity;
		private var _halflife:Number = 2;
		
		public function FollowBehavior(target:GameObject) 
		{
			super();
			_target = target;
		}
		
		override public function update(params:* = null):void 
		{
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