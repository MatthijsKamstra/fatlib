package org.fatlib.game 
{
	import org.fatlib.game.interfaces.IRenderable;
	import org.fatlib.game.interfaces.IUpdatable;
	import org.fatlib.interfaces.IComponent;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IIterator;
	import org.fatlib.struct.Composite;
	
	public class GameObject extends Composite implements IUpdatable, IRenderable, IDestroyable
	{
		private static const GAME_UPDATE:String='update';
		private static const RENDER:String='render';
						
		private var _transform:Transform;
		private var _renderer:GameComponent;
		
		public function GameObject() 
		{
			super();
			_transform = new Transform();
		}
		
		public function update(timeStep:Number = 1):void
		{
			if (children.length == 0) return;
			var it:IIterator = getIterator();
			while (it.hasNext)
			{
				var next:* = it.next;
				if (next is IUpdatable) next.update();
			}
		}
		
		public function render(params:*= null):void
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
		
		override public function add(component:IComponent):void 
		{
			super.add(component);
			if (component is GameComponent)(component as GameComponent).onAdd();
		}
		
		override public function remove(componentName:String):void 
		{
			if (getChild(componentName) is GameComponent)(getChild(componentName) as GameComponent).onRemove();
			super.remove(componentName);
		}
		
		////////////
		
		public function get renderer():GameComponent { return _renderer; }
		
		public function set renderer(renderer:GameComponent):void 
		{
			if (_renderer) remove(_renderer.name);
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