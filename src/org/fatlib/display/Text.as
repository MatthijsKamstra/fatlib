package org.fatlib.display 
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import org.fatlib.utils.DisplayUtils;
	
	/**
	 * An on-screen text implentation subclassing Graphic
	 */
	public class Text extends Graphic
	{
		/**
		 * A Flash TextField 
		 */
		private var _textField:TextField;
		
		/**
		 * TextFormat of the TextField
		 */
		private var _textFormat:TextFormat;
		
		/**
		 * Is it input text?
		 */
		private var _isInput:Boolean;
		
		
		/**
		 * Is it HTML text?
		 */
		private var _isHTML:Boolean;
		
		
		/**
		 * A graphic hiliting the text when it is being edited 
		 */
		private var _inputHilite:Graphic;

		/**
		 * The color of the hilite
		 */
		private var _hiliteColor:int;
		
		/**
		 * The alpha of the hilite
		 */
		private var _hiliteAlpha:Number;
		
		
				
		/**
		 * Is it currently being edtited?
		 */
		private var _beingEdited:Boolean = false;
		
		
		
		
		/**
		 * Creates a new instance
		 * 
		 * @param	text	The text string to display
		 * @param	font	The name of the font to be used. 
		 * @param	size	The font size
		 * @param	color	The font color
		 * @param 	w		The width of the textfield
		 * @param	h		The height of the textfield
		 */
		public function Text(text:String, font:String = null, size:int = 0, isHTML:Boolean = false, color:int = 0x000000, w:Number = 0, h:Number = 0)
		{
			_textField = new TextField();
		
			if (size == 0) size = 16;
			
			if (font)_textField.embedFonts = true;
			
			_textFormat = new TextFormat(font, size);
			
			_textField.textColor = color;
			_isHTML = isHTML;
			
			_textField.multiline = true;			
			
			if (w == 0)
			{
				_textField.autoSize = TextFieldAutoSize.LEFT;
				_textField.wordWrap = false;
			} else {
				_textField.width = w;
				if (h == 0) h = 100;
				_textField.height = h;
				_textField.wordWrap = true;
			}
			
			if (_isHTML)
			{
				_textField.htmlText = text;
			} else {
				_textField.text = text;
			}
			
			setInputHiliteStyle();
			_inputHilite = new Graphic(DisplayUtils.createRectangle(0, 0, 1, 20, _hiliteColor));
			_inputHilite.alpha = _hiliteAlpha;
			_inputHilite.visible = false;
			
			isInput = false;
			
			_textField.addEventListener(TextEvent.TEXT_INPUT, onTextInput);
			
			_textField.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			_textField.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			_textField.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			_textField.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			
			
			var canvas:Graphic = new Graphic();
			canvas.addChild(_inputHilite);
			canvas.addChild(_textField);
			super(canvas);
			
		}
		
		/**
		 * Limit the number of characters
		 */
		public function set characterLimit(limit:int):void
		{
			_textField.maxChars = limit;
		}


		/**
		 * Set the font
		 */
		public function set font(f:String):void
		{
			_textField.embedFonts = true;
			_textFormat.font = f;
			_textField.defaultTextFormat = _textFormat;
			_textField.setTextFormat(_textFormat);
		}
		

		
		/**
		 * Set/get the text string
		 */
		public function set text(t:String):void
		{
			if (_isHTML)
			{
				_textField.htmlText = t;
			} else {
				_textField.text = t;
			}
		}
		
		/**
		 * Set/get the text string
		 */
		public function get text():String
		{
			if (_isHTML) return _textField.htmlText;
			return _textField.text;
		}
		
		
		/**
		 * Set the text color
		 */
		public function set color(c:int):void
		{
			_textField.textColor = c;
		}
		
		public function get isInput():Boolean { return _isInput; }
		
		public function set isInput(value:Boolean):void 
		{
			_isInput = value;
			
			if (_isInput)
			{
				_textField.selectable = true;
				_textField.type = TextFieldType.INPUT;
			} else {
				_textField.selectable = false;
				_textField.type = TextFieldType.DYNAMIC;
			}
		}
		
		public function setInputHiliteStyle(color:int = 0xFFFF00, alpha:Number = 0.3):void 
		{
			_hiliteColor = color;
			_hiliteAlpha = alpha;
		}
		
		override protected function handleMadeInteractive():void 
		{
			super.handleMadeInteractive();
			_textField.selectable = true;
		}
		
		override protected function handleMadeNonInteractive():void 
		{
			super.handleMadeNonInteractive();
			_textField.selectable = false;
		}
		
		/////// events 
				
		private function onTextInput(e:TextEvent):void 
		{
			dispatchEvent(new Event(Event.CHANGE));
		}

		
		private function onFocusIn(e:Event):void 
		{
			if (!_isInput) return;
			_inputHilite.visible = true;
			_beingEdited = true;
		}
				
		private function onFocusOut(e:Event):void 
		{
			if (!_isInput) return;
			_inputHilite.visible = false;
			_beingEdited = false;
		}
		
		private function onRollOver(e:Event):void 
		{
			if (!_isInput) return;
			_inputHilite.visible = true;
		}
				
		private function onRollOut(e:MouseEvent):void 
		{
			if (!_isInput) return;
			if (!_beingEdited) _inputHilite.visible = false;
			
		}
		
		override protected function handleFrame():void 
		{
			_inputHilite.width = _textField.textWidth;
		}
		
		

		
		
	}
	
}