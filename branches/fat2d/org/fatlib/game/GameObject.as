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
	
	public class GameObject extends Composite implements IUpdatable, IRenderable, IDestroyable
	{
		private static const GAME_UPDATE:String='update';
		private static const RENDER:String='render';
						
		private var _transform:Transform;
		private var _renderer:Renderer;
		
		public function GameObject() 
		{
			super();
			_transform = new Transform();
		}
		
		final public function update(timeStep:Number = 1):void
		{
			if (children.length == 0) return;
			var it:IIterator = getIterator();
			while (it.hasNext)
			{
				var next:* = it.next;
				if (next is IUpdatable) next.update();
			}
		}
		
		final public function render(params:*= null):void
		{
			if (children.length == 0) return;
			var it:IIterator = getIterator();
			while (it.hasNext)
			{
				var next:* = it.next;
				if (next is IRenderable) next.render();
			}
		}
		
		public function destroy():void
		{
			var it:IIterator = getIterator();
			while (it.hasNext)(it.next as IDestroyable).destroy();
		}
		
		////////////
		
		public function get renderer():Renderer { return _renderer; }
		
		public function set renderer(renderer:Renderer):void 
		{
			if (_renderer)
			{
				remove(_renderer.name);
				_renderer.destroy();
			}
			_renderer = renderer;
			add(_renderer);
		}
		
		public function get transform():Transform { return _transform; }
		
		public function set transform(value:Transform):void 
		{
			_transform = value;
		}
	}
}