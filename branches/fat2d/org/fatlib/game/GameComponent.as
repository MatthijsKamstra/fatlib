package org.fatlib.game
{
	import org.fatlib.game.interfaces.IRenderable;
	import org.fatlib.game.interfaces.IUpdatable;
	import org.fatlib.struct.Component;

	public class GameComponent extends Component implements IUpdatable, IRenderable
	{
		
		public function GameComponent() 
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
		
		public function onAdd():void
		{
		}
		
		public function onRemove():void
		{
		}
		
	}

}