/*
* ©2010-2012 Van Carney <carney.van@gmail.com> Webfreshener et al
* All Rights Reserved
*
*
*
*
*/
package com.webfreshener.core.utils
{
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.utils.Dictionary;

	import com.webfreshener.core.types.InteractionMode;
	
	/**
	 * 
	 * @author van
	 * 
	 */	
	public class InteractionEventUtil
	{

		public static var MODE:String						= InteractionMode.SINGLE;
		
		public static const INTERACTION_DOWN:String 		= "interactionPressDown";
		public static const INTERACTION_MOVE:String 		= "interactionMove";
		public static const INTERACTION_UP:String 			= "interactionPressRelease";
		public static const INTERACTION_OVER:String 		= "interactionOver";
		public static const INTERACTION_OUT:String 			= "interactionOut";
		public static const INTERACTION_ROLL_OVER:String 	= "interactionRollOver";
		public static const INTERACTION_ROLL_OUT:String 	= "interactionRollOut";
		public static const INTERACTION_CLICK:String 		= "interactionClick";
		
		
		private static var $assignments:Dictionary = new Dictionary(true);
		
		
		
		/**
		 * 
		 * @param uiElement
		 * @param eventName
		 * @param callBack
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 * 
		 */		
		public static function addEventHandler(uiElement:IEventDispatcher, eventName:String, callBack:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=true):void
		{
		  var tEvent:String;
		  if (Multitouch.supportsTouchEvents)
		  {
			  tEvent = lookUpTouchEvent(eventName);
			  
			  uiElement.addEventListener(tEvent, callBack, useCapture, priority, useWeakReference);
			  addHandler(uiElement, eventName, tEvent, callBack, useCapture);
			  
		  }
		  
		  if (!Multitouch.supportsTouchEvents || MODE == InteractionMode.DUAL)
		  {
			  tEvent = lookUpMouseEvent(eventName);
			  
			  uiElement.addEventListener(tEvent, callBack, useCapture, priority, useWeakReference);
			  addHandler(uiElement, eventName, tEvent, callBack, useCapture);

		  }
		}
		
		

		/**
		 * 
		 * @param uiElement
		 * @param eventName
		 * @param callBack
		 * @param useCapture
		 * 
		 */		
		public static function removeEventHandler(uiElement:IEventDispatcher, eventName:String, callBack:Function, useCapture:Boolean=false):void
		{
			if ($assignments[uiElement] && $assignments[uiElement].hasOwnProperty(eventName))
			{
				for (var i:int=0; i<$assignments[uiElement][eventName].length; i++)
					uiElement.removeEventListener($assignments[uiElement][eventName][i]['event'], $assignments[uiElement][eventName][i]['callBack'], $assignments[uiElement][eventName][i]['useCapture']);
				
				delete $assignments[uiElement][eventName];
				
				if ($assignments[uiElement] == null)
					delete $assignments[uiElement];
			}
		}
		
		

		
		
		/**
		 * 
		 * @param uiElement
		 * @param eventName
		 * @param callBack
		 * @param useCapture
		 * 
		 */		
		private static function addHandler(uiElement:IEventDispatcher, iEvent:String, eventName:String, callBack:Function, useCapture:Boolean=false):void
		{
			if (!$assignments[uiElement])
				$assignments[uiElement] = {};
			
			if (!$assignments[uiElement].hasOwnProperty(iEvent))
				$assignments[uiElement][iEvent] = [ {event:eventName, callBack:callBack, useCapture:useCapture} ];
			else
				$assignments[uiElement][iEvent].push( {event:eventName, callBack:callBack, useCapture:useCapture} );
		}
		
		
		
		
		/**
		 * 
		 * @param eventName
		 * @return 
		 * 
		 */		
		private static function lookUpTouchEvent(eventName:String):String
		{
			var str:String = "";

			switch (eventName)
			{
				case InteractionEventUtil.INTERACTION_CLICK:
					str = TouchEvent.TOUCH_TAP;
					break;
				
				case InteractionEventUtil.INTERACTION_DOWN:
					str = TouchEvent.TOUCH_BEGIN;
					break;
				
				case InteractionEventUtil.INTERACTION_UP:
					str = TouchEvent.TOUCH_END;
					break;
				
				case InteractionEventUtil.INTERACTION_MOVE:
					str = TouchEvent.TOUCH_MOVE;
					break;
				
				case InteractionEventUtil.INTERACTION_OVER:
					str = TouchEvent.TOUCH_OVER;
					break;
				
				case InteractionEventUtil.INTERACTION_ROLL_OUT:
					str = TouchEvent.TOUCH_ROLL_OUT;
					break;
				
				case InteractionEventUtil.INTERACTION_ROLL_OVER:
					str = TouchEvent.TOUCH_ROLL_OVER;
					break;
				case InteractionEventUtil.INTERACTION_UP:
					str = TouchEvent.TOUCH_END;
					break;
			}
			
			return str;
		}
		
		
		
		/**
		 * 
		 * @param eventName
		 * @return 
		 * 
		 */		
		private static function lookUpMouseEvent(eventName:String):String
		{
			var str:String = "";
			
			switch (eventName)
			{
				case InteractionEventUtil.INTERACTION_CLICK:
					str = MouseEvent.CLICK;
					break;
				
				case InteractionEventUtil.INTERACTION_DOWN:
					str = MouseEvent.MOUSE_DOWN;
					break;

				case InteractionEventUtil.INTERACTION_MOVE:
					str = MouseEvent.MOUSE_MOVE;
					break;
				
				case InteractionEventUtil.INTERACTION_OUT:
					str = MouseEvent.MOUSE_OUT;
					break;
				
				case InteractionEventUtil.INTERACTION_OVER:
					str = MouseEvent.MOUSE_OVER;
					break;
				
				case InteractionEventUtil.INTERACTION_ROLL_OUT:
					str = MouseEvent.ROLL_OUT;
					break;
				
				case InteractionEventUtil.INTERACTION_ROLL_OVER:
					str = MouseEvent.ROLL_OVER;
					break;
				case InteractionEventUtil.INTERACTION_UP:
					str = MouseEvent.MOUSE_UP;
					break;
			}
			
			return str;
		}
		
	}
}