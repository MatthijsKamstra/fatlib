package org.fatlib.game
{
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IRenderable;
	import org.fatlib.interfaces.IUpdatable;
	import org.fatlib.struct.Component;

	public class GameComponent extends Component implements IUpdatable, IRenderable, IDestroyable
	{
		
		public function GameComponent() 
		{
		}
		
		public function destroy():void
		{
		}
		
		public function update(timeStep:Number = 1):void
		{
		}
		
		public function render(params:* = null):void
		{
		}
				
		public function get gameObject():GameObject
		{
			if (!parent) return null;
			if (parent is GameObject) return parent as GameObject;
			return null;
		}
		
	}

}