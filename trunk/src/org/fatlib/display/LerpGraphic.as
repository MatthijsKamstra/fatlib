package org.fatlib.display
{
	import flash.display.DisplayObject;
	import org.fatlib.display.Graphic;
	
	public class LerpGraphic extends Graphic
	{
		
		private var _tx:Number;
		private var _ty:Number;
		private var _ta:Number;
		private var _tw:Number;
		private var _th:Number;
		
		private var _lerpX:Number = 2;
		private var _lerpY:Number = 2;
		private var _lerpA:Number = 2;
		private var _lerpW:Number = 2;
		private var _lerpH:Number = 2;
		
		private var _threshold:Number = 1;
		
		
		private var _useAcceleration:Boolean;
		
		/// if useAcceleration is true, use these:
		private var _drag:Number = 1.5;				// 1=no drag. 2=half velocity each frame.
		private var _xv:Number = 0;
		private var _yv:Number = 0;
		private var _wv:Number = 0;
		private var _hv:Number = 0;
		private var _av:Number = 0;
		
		
		public function LerpGraphic(defaultState:DisplayObject = null, useAcceleration:Boolean=false) 
		{
			super(defaultState);
			cancelTarget();
			
			_useAcceleration = useAcceleration;
		}
		
		public function matchTarget():void
		{
			x = _tx;
			y = _ty;
			alpha = _ta;
			width = _tw;
			height = _th;
			zeroVelocities();
		}
		
		public function cancelTarget():void
		{
			_tx = x;
			_ty = y;
			_ta = alpha;
			_tw = width;
			_th = height;
			zeroVelocities();
		}
		
		private function zeroVelocities():void
		{
			_xv = _yv = _wv = _hv = _av = 0;
		}
		
		override protected function handleFrame():void 
		{
			
			if (_useAcceleration)
			{
				_xv += (_tx - x) / _lerpX;
				_yv += (_ty - y) / _lerpY;
				_av += (_ta - alpha) / _lerpA;
				_wv += (_tw - width) / _lerpW;
				_hv += (_th - height) / _lerpA;
				
				x += _xv;
				y += _yv;
				width += _wv;
				height += _hv;
				alpha += _av;
				
				_xv /= _drag;
				_yv /= _drag;
				_wv /= _drag;
				_hv /= _drag;
				_av /= _drag;
				
			} else {
				x += (_tx - x) / _lerpX;
				y += (_ty - y) / _lerpY;
				alpha += (_ta - alpha) / _lerpA;
				width += (_tw - width) / _lerpW;
				height += (_th - height) / _lerpA;
				
				if (Math.abs(_tx - x) < _threshold) x = _tx;
				if (Math.abs(_ty - y) < _threshold) y = _ty;
				if (Math.abs(_tw - width) < _threshold) width = _tw;
				if (Math.abs(_th - height) < _threshold) height = _th;
			}
		}
		
		
		public function set tx(value:Number):void {_tx = value;}
		public function set ty(value:Number):void {_ty = value;}
		public function set ta(value:Number):void {_ta = value;}
		public function set tw(value:Number):void {_tw = value;}
		public function set th(value:Number):void {_th = value;}
		
		public function set lerpX(value:Number):void {_lerpX = value;}
		public function set lerpY(value:Number):void {_lerpY = value;}
		public function set lerpA(value:Number):void {_lerpA = value;}
		public function set lerpW(value:Number):void {_lerpW = value;}
		public function set lerpH(value:Number):void {_lerpH = value;}
		
		public function set threshold(value:Number):void {_threshold = value;}
		
		public function set drag(value:Number):void {_drag = value;}
		
		
	}

}