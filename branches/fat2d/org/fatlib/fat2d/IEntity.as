package org.fatlib.fat2d 
{
	public interface IEntity
	{
		function update(timeStep:Number = 0):void;
		function render(canvas:Canvas = null):void;
	}

}