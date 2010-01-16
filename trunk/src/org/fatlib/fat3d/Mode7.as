package org.fatlib.fat3d
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.fatlib.interfaces.IDestroyable
	
	public class Mode7 extends Sprite implements IDestroyable
	{
		private var	_nbMs:Number;
		private var	_oldTime:Number;
		private var	_time:Number;
		private var	_resoDx:Number;
		private var	_resoDy:Number;
		private var	_nbScans:Number;
		private var	_scanSteps:Number;	
		private var _bmpd:BitmapData;
		private var offsetX:Number;
		private var offsetY:Number;
		private var container:Sprite;
		private var _hiDef:Boolean = true;
		
		public function Mode7(viewport:Rectangle, bmpd:BitmapData)
		{
			_resoDx = viewport.width;
			_resoDy = viewport.height;
		
			
			var	i:int;
			container = new Sprite();
			addChild(container);
			
			_bmpd = new BitmapData(bmpd.width, bmpd.height);
			var g:Sprite = new Sprite();
			var b:Bitmap = new Bitmap(bmpd);
			g.addChild(b);
			b.rotation = 90;
			b.x += b.width;
			_bmpd.draw(g);
			
			
			if (!_hiDef)
			{
				_scanSteps = 2;
				_nbScans = (_resoDy >> 1);
			} else {
				_scanSteps = 1;
				_nbScans = _resoDy;
			}
			// create and place scan lines
			for(i = 0; i < _nbScans; i++)
			{
				var scan:Sprite=container.addChild(new Sprite()) as Sprite;
				scan.x = viewport.x + (_resoDx * 0.5);
				scan.y = viewport.y + (i * _scanSteps);
				//var dist:Number = 1 - (i / _nbScans) * 1.5;
				//var trans:ColorTransform = RacingGame.getFog(dist);
				//scan.transform.colorTransform = trans;
			}
		}
		
		public function destroy():void
		{
			while (container.numChildren > 0)
				container.removeChildAt(0);
		}
		
		public function render(worldCamera:Camera3D):void
		{		
			
			var camera:Camera3D = worldCamera.clone() as Camera3D;
			camera.angleY = -camera.angleY-Math.PI/2;
			
			camera.x = -worldCamera.z;
			camera.z = -worldCamera.x;
			//camera.y = -500;
			camera.angleX = -camera.angleX;
			
			
			var	i:Number;
			var	x2:Number;
			var	x2b:Number;
			var	colX:Number;
			var	colZ:Number;
			var	rayX:Number;
			var	rayY:Number;
			var	rayZ:Number;
			var	cfX:Number;
			var	angleX:Number;
			var	dist:Number;
			var	alpha:Number;
			var	leCos:Number;
			var	sinus:Function;	
			var	cosinus:Function;
			var	matrix:Matrix;
			sinus = Math.sin;
			cosinus = Math.cos;
			matrix = new Matrix(); 
			matrix.rotate(camera.angleY);
			x2 =  (_resoDx * 0.5) /550// 250.0;
			cfX = (50.0 / _nbScans)  * Math.PI / 180.0;
			angleX = camera.angleX - (cfX * _nbScans * 0.5);
			rayX = sinus(camera.angleY);
			rayZ = cosinus(camera.angleY);
			i = -1;
			for (i = 0; i < container.numChildren;i++)
			{
				var scan:Sprite = container.getChildAt(i) as Sprite;
				scan.graphics.clear();
				angleX += cfX;
				rayY = sinus(angleX);	// dot prod ray (rayX, rayY, rayZ) with plane (0.0, 1.0, 0.0)
				
				if(rayY < 0.0)
				{
					// over horizon
					continue;
				}
				dist = (camera.y / rayY);				// distance to hit point on plane
				/*
				alpha = _horizon - (dist / _horizonScale);
				
				if(alpha < 1.0)
				{
					// too far
					continue;
				}
				scan.alpha = alpha;
				*/
				leCos = cosinus(angleX) * dist;
				colX = camera.x - (rayX * leCos);		// x of hit point on plane
				colZ = camera.z - (rayZ * leCos);		// z of hit point on plane
				matrix.tx = (colX * matrix.a) + (colZ * matrix.c) ;
				matrix.ty = (colX * matrix.b) + (colZ * matrix.d) ;
				x2b = (x2 * dist); 			
						
				
				// scale src
				//scan.scaleX = (_worldScale / dist);	// scale tgt
				scan.scaleX = -(camera.focalLength / dist);	// scale tgt
				
			//	scan.graphics.beginBitmapFill(_bmpd, matrix, false, true);
				scan.graphics.beginBitmapFill(_bmpd, matrix, true, true);
				//scan.graphics.beginBitmapFill(_bmpd, matrix,Config.MODE7_REPEAT,Config.MODE7_SMOOTH);
				scan.graphics.drawRect(-x2b, 0, x2b*2, _scanSteps);
				scan.graphics.endFill();
			}		
		}
	}		
}