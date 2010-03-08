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
			if (children.length == 0) return;
			var it:IIterator = getIterator();
			while (it.hasNext)(it.next as IUpdatable).update(params);
		}
		
		final public function render(params:*= null):void
		{
			handleRender(params);	
			if (children.length == 0) return;
			var it:IIterator = getIterator();
			while (it.hasNext)(it.next as IRenderable).render(params);
		}
		
		public function destroy():void
		{
			_destroyList.destroy();
		}
			
		
		////////////
		
		protected function handleGameUpdate(timeStep:Number = 1):void
		{
		}
		
		protected function handleRender(params:*= null):void
		{
		}
		
		
	}
}