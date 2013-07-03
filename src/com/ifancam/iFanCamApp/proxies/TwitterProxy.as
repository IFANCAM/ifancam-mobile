package com.ifancam.iFanCamApp.proxies
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.oauth.events.OAuthTwitterEvent;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class TwitterProxy extends Proxy
	{
		public static const NAME:String = "TwitterProxy";
		
		private var $api:TwitterAPI;
		private var $authorized:Boolean = false;
		
		
		override public function onRegister():void
		{
			super.onRegister();
			$api = new TwitterAPI();
			$api.connection.addEventListener(OAuthTwitterEvent.REQUEST_TOKEN_RECEIVED, handleRequestTokenReceived);
			$api.connection.addEventListener(OAuthTwitterEvent.REQUEST_TOKEN_ERROR, handleRequestTokenError);
			$api.connection.addEventListener(OAuthTwitterEvent.ACCESS_TOKEN_ERROR, handleAccessTokenError);
			$api.connection.addEventListener(OAuthTwitterEvent.AUTHORIZED, handleAuthorized);
			$api.connection.authorize();
		}
		
		
		public function login():void
		{
			
		}
		
		public function logout():void
		{
			
		}
		
		protected function handleRequestTokenReceived(event:OAuthTwitterEvent):void
		{
//			authHTML.url = twitterApi.connection.authorizeURL;
		}
		
		protected function handleRequestTokenError(event:OAuthTwitterEvent):void
		{
//			status = "Connection error";
		}
		
		protected function handleAccessTokenError(event:OAuthTwitterEvent):void
		{
//			status = "Error of receiving access token";
		}
		
		protected function handleAuthorized(event:OAuthTwitterEvent):void
		{
			$authorized = true;
		}
		
		public function TwitterProxy(data:Object=null)
		{
			super(NAME, data);
		}
	}
}