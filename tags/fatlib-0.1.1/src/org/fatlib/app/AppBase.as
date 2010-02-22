package org.fatlib.app
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import org.fatlib.assets.AssetBank;
	import org.fatlib.interfaces.IDisplayable;
	import org.fatlib.utils.NetUtils;
	
	public class AppBase implements IDisplayable
	{
		protected var _flashvars:Object;
		protected var _assets:AssetBank;
		protected var _config:Config;
		protected var _display:DisplayObjectContainer;
		protected var _processes:ProcessMap;
		
		public function AppBase(stage:Stage) 
		{
			_flashvars = NetUtils.getFlashVars(stage);
			_assets = new AssetBank();
			_config = new Config();
			_display = new Sprite();
			_processes= new ProcessMap();
			stage.addChild(_display);
		}
		
		public function get display():DisplayObjectContainer { return _display;}
		public function get assets():AssetBank { return _assets; }
		public function get flashvars():Object { return _flashvars; }
		public function get config():Config { return _config; }
		public function get processes():ProcessMap { return _processes; }
		
	}
}