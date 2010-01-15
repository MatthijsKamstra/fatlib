package org.fatlib.process
{
	import flash.errors.IllegalOperationError;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.process.SyncProcess;
	
	/**
	 * A synchronous process that calls a given method
	 */
	public class Callback extends SyncProcess
	{
		private var _method:Function;
		private var _params:Array;
		
		/**
		 * Creates a new instance
		 * 
		 * @param	methodToCall	The method to call when the Callback is executed
		 * @param	methodParams	The paramters to pass to the method
		 */
		public function Callback(methodToCall:Function, methodParams:Array=null) 
		{
			_method = methodToCall;
			
			if (methodParams == null) methodParams = [];
			_params = methodParams;
			if (_params.length > 6)
				throw new IllegalOperationError("Can't pass more than 6 parameters");
		}
		
		/**
		 * Calls the given method with the given parameters
		 */
		override public function execute():void 
		{
			
			// Not sure if AS3 has a proper way of doing this...
			
			switch(_params.length)
			{
				case 0:
					_method();
					break;
				case 1:
					_method(_params[0]);
					break;
				case 2:
					_method(_params[0],_params[1]);
					break;
				case 3:
					_method(_params[0],_params[1],_params[2]);
					break;
				case 4:
					_method(_params[0],_params[1],_params[2],_params[3]);
					break;
				case 5:
					_method(_params[0],_params[1],_params[2],_params[3],_params[4]);
					break;
				case 6:
					_method(_params[0],_params[1],_params[2],_params[3],_params[4],_params[5]);
					break;
				default:
					_method(_params[0], _params[1], _params[2], _params[3], _params[4], _params[5]);
					break;
			}
		}

	}
	
}