package org.fatlib.game 
{
	import org.fatlib.interfaces.IComponent;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IIterator;
	import org.fatlib.interfaces.IRenderable;
	import org.fatlib.interfaces.IUpdatable;
	import org.fatlib.struct.Composite;
	import org.fatlib.utils.Delay;
	import org.fatlib.utils.DestroyList;
	
	public class GameComponent extends Composite implements IUpdatable, IRenderable, IDestroyable
	{
		private static const GAME_UPDATE:String='update';
		private static const RENDER:String='render';
						
		protected var _destroyList:DestroyList;
		protected var _delay:Delay;
		
		private var _world:GameComponent;
		
		public function GameComponent() 
		{
			super();
			_destroyList = new DestroyList();
			_delay = new Delay();
			_destroyList.add(_delay);
		}
		
		final public function update(params:*= null):void
		{
			handleGameUpdate(params);
			var it:IIterator = getIterator();
			while (it.hasNext)(it.next as IUpdatable).update(params);
		}
		
		final public function render(params:*= null):void
		{
			handleRender(params);	
			var it:IIterator = getIterator();
			while (it.hasNext)(it.next as IRenderable).render(params);
		}
		
		public function destroy():void
		{
			_destroyList.destroy();
		}
		
		public function set world(w:GameComponent):void
		{
			_world = w;
		}
		
		public function get world():GameComponent 
		{
			if (_world) return _world;
			if (parent) return (parent as GameComponent).world;
			return null;
		}
		
		
		////////////
		
		protected function handleGameUpdate(timeStep:Number = 0):void
		{
		}
		
		protected function handleRender(params:*= null):void
		{
		}
		
		
	}
}