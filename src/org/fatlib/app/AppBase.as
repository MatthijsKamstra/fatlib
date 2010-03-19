package org.fatlib.app
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import org.fatlib.assets.AssetBank;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.interfaces.IDisplayable;
	import org.fatlib.utils.DestroyList;
	import org.fatlib.utils.NetUtils;
	
	public class AppBase implements IDisplayable, IDestroyable
	{
		
		private var _destroyList:DestroyList;
		
		private var _flashvars:Object;
		private var _config:Config;
		private var _display:DisplayObjectContainer;
		private var _processes:ProcessMap;
		private var _instance:AppBase;
		
		public function AppBase(stage:Stage) 
		{
			_instance = this;
			_flashvars = NetUtils.getFlashVars(stage);
			_config = new Config();
			_display = new Sprite();
			_processes = new ProcessMap();
			_destroyList = new DestroyList();
			stage.addChild(_display);
		}
		
		public function get display():DisplayObjectContainer { return _display;}
		public function get flashvars():Object { return _flashvars; }
		public function get config():Config { return _config; }
		public function get processes():ProcessMap { return _processes; }
		public function get instance():AppBase { return _instance; }
		
		public function get destroyList():DestroyList { return _destroyList; }
		
		public function destroy():void
		{
			_destroyList.destroy();
		}
		
		
	}
}