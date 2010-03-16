package org.fatlib.game.standard 
{
	import org.fatlib.game.standard.ICarrier;
	
	public class CarryBehavior implements ICarrier
	{
		
		protected var _carried:Object;
		
		public function CarryBehavior() 
		{
			super();
			name = 'carrier';
			_carried = {};
		}
		
		public function collect(amount:Number, type:*):Number
		{
			if (!_carried[type])_carried[type] = 0;
			_carried[type] += amount;
			return amount;
		}
		
		public function drop(amount:Number, type:*):Number
		{
			if (!_carried[type])_carried[type] = 0;
			if (amount > getAmount(type)) amount = getAmount(type);
			_carried[type] -= amount;
			return amount;
		}
		
		public function transfer(target:ICarrier, amount:Number, type:*):Number
		{
			if (amount > getAmount(type)) amount = getAmount(type) - amount;
			target.collect(amount, type);
			drop(amount, type);
			return amount;
		}
		
		public function getAmount(type:*):Number
		{
			if (_carried[type]) return _carried[type];
			return 0;
		}
		
		public function getAll():Object
		{
			var clone:Object = { };
			for (var s:* in _carried) clone[s] = _carried[s];
			return clone;
		}
		
		public function dropAll():void
		{
			_carried = { };
		}
		
	}

}