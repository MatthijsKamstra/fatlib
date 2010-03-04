package org.fatlib.display
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import org.fatlib.interfaces.IDestroyable;
	import org.fatlib.utils.ClassUtils;
	import org.fatlib.utils.Delay;
	
	/**
	 * The Graphic class is subclass of Sprite that provides the following functionality:
	 * 
	 * 1. States
	 * Rather than use frames of a MovieClip, graphical states can be registered with the Graphic. 
	 * For instance, the 'up' and 'over' states of a button or the 'unhilited' and 'hilited' states of a tab.
	 * This makes Graphic a useful alternative to MovieClip when multistate graphics are needed, without
	 * using the Flash IDE to prepare timelines
	 *
	 * 2. Interactivity
	 * The Graphic class provides shortcuts with regards to mouse- and tab- enabledness
	 * 
	 */
	public class Graphic extends Sprite implements IDestroyable
	{
		/**
		 * The defualt state, if any, provided when the object was instantiated
		 */
		public static const DEFAULT:String = 'default';
		
		/**
		 * A blank state, provided automatically
		 */
		public static const BLANK:String = 'blank';
		
		/**
		 * An index of all the object's states
		 */
		private var _states:Object;
		
		/**
		 * The current state
		 */
		private var _currentState:DisplayObject;
		
		/**
		 * The name of the current state
		 */
		private var _currentStateName:String;
		
		/**
		 * Is this object ever interactive?
		 */
		private var _interactable:Boolean;
		
		/**
		 * Are this object's children ever interactive?
		 */
		private var _childrenInteractable:Boolean;
		
		/**
		 * Is this object (and its children) interactive right now?
		 */
		private var _interactive:Boolean;
		
		/**
		 * An object for user data - can be used in any way like the dynamic property of a MovieClip
		 */
		private var _userData:Object = {};
		
	
		
		
		/**
		 * Creates a new Graphic instance.
		 * 
		 * @param	defaultState The state assigned to the name DEFAULT, if any.
		 */
		public function Graphic(defaultState:DisplayObject = null) 
		{
			super();
			
			_states = [];
			registerState(BLANK, new MovieClip());
			if (defaultState)
			{
				registerState(DEFAULT, defaultState);
				showState(DEFAULT);
			}
			
			_interactable = false;
			_childrenInteractable = true;
			
			interactive = true;
			
			addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
			
		}
		
		/////////////// PUBLIC METHODS
		
		// STATES
		
		/**
		 * Registers a display object to the graphic
		 * 
		 * @param	name		A unique name (string or int) identifying the state
		 * @param	state	The graphic that this state represents
		 */
		public function registerState(name:*, state:DisplayObject=null):void
		{
			if (!state) 
			{
				state = new Sprite();
			}
			_states[name] = state;
		}
		
		/**
		 * Shows the specified state
		 * 
		 * @throws IllegalOperationError	if the state does not exist
		 * @param	name		The name idetifying the state to be shown
		 */
		public function showState(name:*):void
		{
			if (hasState(name)) 
			{
				if (_currentState)removeChild(_currentState);
				_currentState = getState(name);
				_currentStateName = name;
				addChild(_currentState);
			} else {
				throw new IllegalOperationError('No such state as ' + name);
				Log.warn("[Graphic "+name+"] no such state as " + name );
			}
		}
		
		/**
		 * Gets the current state
		 */
		public function get currentState():DisplayObject { return _currentState; }
		
		/*
		 * Gets the name of the current state
		 */
		public function get currentStateName():* { return _currentStateName;}

		/**
		 * Checks whether the state with the given name has been registered
		 * 
		 * @param	name	The name of the state to check
		 * @return	Has the state with the given name has been registered?
		 */
		public function hasState(name:*):Boolean
		{
			return _states[name]!=undefined;
		}

		/**
		 * Gets the child of the object with the specified name.
		 * This is a convenient version of DisplayObject.getChildByName() which returns an untyped object.
		 * 
		 * @param	childName	The name of the child to find
		 * @throws	IllegalOperationError	If the child doesn't exist
		 * @return	the child of the object with the specified name
		 */
		public function getChild(childName:String):*
		{
			var child:* = getChildByName(childName);
			//if (!child)	throw new IllegalOperationError("Couldn't find child '" + childName + "' in '" + this.name+"'");
			return getChildByName(childName)
		}
		
		/**
		 * Checks whether the object has a child with the specified name
		 * 
		 * @param	childName	The name of the child to check
		 * @return	Does the object have a child with the specified name?
		 */
		public function hasChild(childName:String):Boolean
		{
			var child:* = getChildByName(childName);
			return (child != null);
		}
		
				
		/**
		 * Get the number of states registered on this object
		 * 
		 * @param	includeBlank	Include the BLANK state, which is automatically registered/
		 * @return	The number of states registered 
		 */
		public function getNumStates(includeBlank:Boolean = false):int
		{
			var count:int = 0;
			for (var s:String in _states)
				if (s != BLANK || includeBlank) count++;
			return count;
		}

		
		public function getState(name:*):DisplayObject
		{
			return _states[name];
		}
		
		
		/**
		 * Called every frame
		 */
		protected function handleFrame():void
		{
		}
		
		
		/**
		 *	Called when the object is no longer needed
		 */
		public function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, onFrame);
		}		
		
		// UI 
		
		public function get interactable():Boolean { return _interactable; }
		
		public function set interactable(value:Boolean):void 
		{
			_interactable = value;
			interactive = _interactive;
		}
		
		public function get childrenInteractable():Boolean { return _childrenInteractable; }
		
		public function set childrenInteractable(value:Boolean):void 
		{
			_childrenInteractable = value;
			interactive = _interactive;
		}
		
		
		/**
		 * Sets whether the object acts as button or not
		 * If set to true, the object will be set to interactable, its children will be set to non-interactable,
		 * and display the hand cursor when under the mouse pointer.
		 */
		public function set actAsButton(b:Boolean):void
		{
			buttonMode = useHandCursor = b;
			interactable = true;
			childrenInteractable = false;
		}
		
		/**
		 * 	Set whether this object is interactive or not.
		 */
		public function set interactive(value:Boolean):void 
		{
			_interactive = value;
			if (_interactive)
			{
				mouseEnabled = tabEnabled = _interactable;
				mouseChildren = tabChildren = _childrenInteractable;
				handleMadeInteractive();
			} else {
				mouseChildren = tabChildren = false;
				mouseEnabled = tabEnabled = false;
				handleMadeNonInteractive();
			}
		}
		
		public function get interactive():Boolean
		{
			return _interactive;
		}
		
		public function get userData():Object { return _userData; }
		
		public function set userData(value:Object):void 
		{
			_userData = value;
		}
		
		
		
		/////////////// PROTECTED METHODS 
		
		/**
		 * Called when the interactive property is set to true
		 */
		protected function handleMadeInteractive():void
		{
		}
		
		/**
		 * Called when the interactive propery is set to false
		 */
		protected function handleMadeNonInteractive():void
		{
		}

		
		///////////// PRIVATE METHODS
		
		private function onFrame(e:Event):void 
		{
			handleFrame();
		}
		
	}
	
}