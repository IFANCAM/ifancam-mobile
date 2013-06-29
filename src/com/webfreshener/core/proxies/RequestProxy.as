package com.webfreshener.core.proxies
{
	import com.webfreshener.core.types.ApiRequestMethod;
	import com.webfreshener.core.types.ResponseFormats;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.system.Security;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class RequestProxy extends Proxy
	{
		private var $loader:URLLoader;
		protected var _urlReq:URLRequest;
		
		private var $response:*;
		
		//-- are we using a RESTful API?
		private var $useREST:Boolean = true;
		
		public function get restfull():Boolean
		{
			return $useREST;
		}
		
		public function set restfull(value:Boolean):void
		{
			$useREST = value;
		}
		
		public function get response():*
		{
			return $response;
		}
		
		
		public function serialize(value:*):String
		{
			return JSON.stringify( value );
		}

		public function get fromJSON():Object
		{
			return JSON.parse( this.$response );
		}
		
		public function get toJSON():String
		{
			return JSON.stringify( this.$response );
		}
		
		
		private var _requestMethod:String = ApiRequestMethod.GET;
		
		public function get requestMethod():String
		{
			return _requestMethod;
		}
		
		public function set requestMethod(value:String):void
		{
			if (value != _requestMethod)
			{
				if (restfull && value == (ApiRequestMethod.GET  || 
					ApiRequestMethod.POST || 
					ApiRequestMethod.PUT  || 
					ApiRequestMethod.DELETE))
					this._urlReq.requestHeaders.push(new URLRequestHeader("_method", value));
				_requestMethod = value;
			}

		}

		/**
		 * 
		 * @param headers
		 * 
		 */		
		final public function set requestHeaders(headers:Array):void
		{
			//-- seek and destroy any user-generated OAUTH headers or raw objects
			for (var i:int=0; i<headers.length; i++)
				if (!(headers[i] is URLRequestHeader))
					headers.splice(i, 1);
			
			_urlReq.requestHeaders.concat(headers);
		}
		
		
		
		
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set source( value:String ):void
		{
			_urlReq.url = value;
		}
		
		public function get source():String
		{
			return _urlReq.url;
		}
		
		
		
		public function load():void
		{
			if ( !source )
				return;
			
			$loader = new URLLoader();
			$loader.addEventListener( Event.COMPLETE, completeHandler, false, 0, true );
			$loader.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true );
			$loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true );
			
			$loader.load( _urlReq );
		}
		
		protected function completeHandler( event:Event ):void
		{
			//-- override and call this in your subclass
			$response = $loader.data;
			$loader.removeEventListener( Event.COMPLETE, completeHandler, false );
			$loader.removeEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler, false );
			$loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false );
			$loader = null;
			_urlReq.data = null;
		}
		
		protected function ioErrorHandler( event:IOErrorEvent ):void
		{
			//-- override this in your subclass
		}
		
		protected function securityErrorHandler( event:SecurityErrorEvent ):void
		{
			//-- override this in your subclass
		}
		
		
		override public function onRegister():void
		{
			super.onRegister();
			Security.loadPolicyFile('http://ifancam.com/crossdomain.xml');
		}
		
		public function RequestProxy(name:String, useREST=true)
		{
			super( name );
			$useREST = useREST;
			_urlReq = new URLRequest();
		}
	}
}