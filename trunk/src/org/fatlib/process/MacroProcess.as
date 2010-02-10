package org.fatlib.process
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import org.fatlib.interfaces.IProcess;
	
	/**
	 * A process which consists of a list of subprocess to be executed sequentially
	 */
	public class MacroProcess extends AsyncProcess
	{
		protected var _processes:Array;
		protected var _currentProcess:IProcess;
		
		/**
		 * Start as soon as the first subprocess is added?
		 */
		private var _autoExecute:Boolean = false;
		
		/**
		 * Start the next process as soon as a process completes?
		 */
		private var _autoContinue:Boolean = true;
		
		
		/**
		 * Creates a new instance
		 */
		public function MacroProcess() 
		{
			super();
			_processes = [];
		}
		
		/**
		 * Starts the first subprocess
		 */
		override public function execute():void
		{
			startNextProcess();
		}
		
		/**
		 * Adds a subprocess
		 * 
		 * @param	p	The process to add
		 */
		public function addProcess(p:IProcess):void
		{
			_processes.push(p);
			if (_processes.length == 1 && _autoExecute) execute();
		}
		
		/**
		 * Terminates the process
		 */
		override public function terminate():void 
		{
			
			_processes = null;
			super.terminate();
		}
		
		
		public function get autoContinue():Boolean { return _autoContinue; }
		
		public function set autoContinue(value:Boolean):void 
		{
			_autoContinue = value;
		}
		
		public function get autoExecute():Boolean { return _autoExecute; }
		
		public function set autoExecute(value:Boolean):void 
		{
			_autoExecute = value;
		}
		
		////////////////

		private function startNextProcess():void
		{
			if (_processes.length == 0) 
			{
				done();
				return;
			}

			_currentProcess = _processes[0] as IProcess;
			
			if (_currentProcess is AsyncProcess)
			{
				var async:AsyncProcess = _currentProcess as AsyncProcess;
				async.addEventListener(Event.COMPLETE, onSubprocessComplete);
				async.execute();
			} else {
				_currentProcess.execute();
				subprocessComplete();
			}
		}
		
		private function onSubprocessComplete(e:Event):void 
		{
			subprocessComplete()
		}
		
		private function subprocessComplete():void
		{
			killCurrentProcess();
			_processes.shift();
			
			if (_autoContinue)
			{
				startNextProcess();
			} 
		}
		
	
		
		private function killCurrentProcess():void
		{
			if (!_currentProcess) return;
			
			if(_currentProcess is AsyncProcess)
			{
				var async:AsyncProcess = _currentProcess as AsyncProcess;
				async.removeEventListener(Event.COMPLETE, onSubprocessComplete);
				async.destroy();
			}
			
			_currentProcess = null;
			
		}
		
		
	
	}
}