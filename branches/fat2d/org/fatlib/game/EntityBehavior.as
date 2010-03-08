package org.fatlib.game 
{
	public class EntityBehavior extends GameComponent
	{
		public function EntityBehavior() 
		{
			super();
		}
		
		public function get entity():Entity
		{
			if (parent is Entity) return parent as Entity;
			return null;
		}
	}
}