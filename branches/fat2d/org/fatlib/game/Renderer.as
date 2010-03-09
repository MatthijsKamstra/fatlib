package org.fatlib.game 
{
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IRenderable;
	import org.fatlib.struct.Component;
	
	public class Renderer extends Component implements IRenderable, IDestroyable
	{
		
		public function Renderer() 
		{
		}
		
		public function destroy():void
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