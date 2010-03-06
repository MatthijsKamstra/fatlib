package org.fatlib.game 
{
	import org.fatlib.comp.Component;
	import org.fatlib.comp.Composite;
	import org.fatlib.interfaces.IComponent;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IIterator;
	import org.fatlib.interfaces.IRenderable;
	import org.fatlib.interfaces.IUpdatable;
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
			var it:IIterator = getIterator();
			handleGameUpdate(params);
			while (it.hasNext)(it.next as IUpdatable).update(params);
		}
		
		final public function render(params:*= null):void
		{
			var it:IIterator = getIterator();
			handleRender(params);	
			while (it.hasNext)(it.next as IRenderable).render(params);
		}
		
		public function destroy():void
		{
			_destroyList.destroy();
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