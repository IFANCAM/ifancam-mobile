package com.webfreshener.core.proxies
{
	import com.webfreshener.core.utils.Base64Codec;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.SharedObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	/**
	 * 
	 * @author van
	 * 
	 */
	public class SharedObjectProxy extends Proxy implements IEventDispatcher 
	{
		private var $so:SharedObject = null;
		private var _bindingEventDispatcher:EventDispatcher;
		
		public function SharedObjectProxy(name:String, data:Object=null)
		{
			_bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
			super(NAME, data);
		}
		
		
		public function addSetting(name:String, value:Object):void
		{
			$so.setProperty(name, Base64Codec.encodeObject(value));
			$so.flush();
		}
		
		public function deleteSetting(value:Object):void
		{
			if (value.hasOwnProperty('name'))
				deleteSettingByName(value.name);
		}
			

		public function deleteSettingByName(name:String):void
		{
			if ($so.data.hasOwnProperty(name)){
				delete $so.data[name];
			};
		}


		override public function onRegister():void
		{
			try {
				$so = SharedObject.getLocal(getProxyName(), "/");
			}
			catch(e:Error) {
				trace("[SharedObjectProxy] onRegister Caught Error: " + e.message);
			}
		}
		
		
		override public function onRemove():void{
			$so.flush();
			$so = null;
		}

		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, weakRef:Boolean=false):void
		{
			_bindingEventDispatcher.addEventListener(type, listener, useCapture, priority, weakRef);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return (_bindingEventDispatcher.dispatchEvent(event));
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return (_bindingEventDispatcher.hasEventListener(type));
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			_bindingEventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return (_bindingEventDispatcher.willTrigger(type));
		}
		
	}