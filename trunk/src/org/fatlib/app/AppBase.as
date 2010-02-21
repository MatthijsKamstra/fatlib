package org.fatlib.app
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import org.fatlib.interfaces.ICanvas;
	import org.fatlib.utils.NetUtils;
	
	import org.fatlib.assets.AssetBank;
	import org.fatlib.display.Graphic;
	
	public class AppBase implements ICanvas
	{
		private var _screens:ScreenManager;
		private var _flashvars:Object;
		private var _assets:AssetBank;
		private var _config:Config;
		private var _canvas:DisplayObjectContainer;
		
		public function AppBase(stage:Stage) 
		{
			_flashvars = NetUtils.getFlashVars(stage);
			_assets = new AssetBank();
			_config = new Config();
			_canvas = new Sprite();
			stage.addChild(_canvas);
		}
		
		public function get canvas():DisplayObjectContainer { return _canvas;}
		public function get assets():AssetBank { return _assets; }
		public function get flashvars():Object { return _flashvars; }
		public function get config():Config { return _config; }
		
	}
}