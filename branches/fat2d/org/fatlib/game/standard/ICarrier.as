package org.fatlib.game.standard 
{
	public interface ICarrier 
	{
		function collect(amount:Number, type:*):Boolean;	// returns true if collection successful
		function drop(amount:Number, type:*):void;
		function transfer(target:ICarrier, amount:Number, type:*):Boolean;	// returns true if successful
		function getAmount(type:*):Number;
		function getAll():Object;	// returns a hash keyed by type eg {salami:12, ham:10}
		function dropAll():void;
	}
	
}