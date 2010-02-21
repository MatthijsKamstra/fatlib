package org.fatlib.app 
{
	import org.fatlib.interfaces.IProcess;
	public class ProcessMap
	{
		private var _processes:Object;
		
		public function ProcessMap()
		{
			_processes = { };
		}
		
		public function register(name:String, processClass:Class):void
		{
			_processes[name] = processClass;
		}
		
		public function remove(name:String):void
		{
			_processes[name] = null;
		}
		
		public function trigger(name:String):void
		{
			if (_processes[name])
			{
				var p:IProcess = new _processes[name]();
				p.execute();
			}
		}
	}

}