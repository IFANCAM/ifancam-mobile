package com.ifancam.iFanCamApp.proxies
{
	import com.facebook.graph.FacebookMobile;
	import com.ifancam.iFanCamApp.mediators.ApplicationMediator;
	
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;

	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	/**
	 * 
	 * @author van
	 * 
	 */	
	public class FacebookProxy extends Proxy
	{
		public static const NAME:String = "FacebookProxy";
		
		private var $appKey:String		= ApplicationFacade.FACEBOOK_APP_KEY;
		private var $appSecret:String	= ApplicationFacade.FACEBOOK_APP_SECRET;
		
		private var $token:String;
		
		override public function onRegister():void
		{
			super.onRegister();
			FacebookMobile.init($appKey, onInit, null);
		}
		
		protected function onInit(success:Object, fail:Object):void
		{
			if (fail != null)
				login()
		}
		
		protected function getAppStage():Stage
		{
			var appMediator:ApplicationMediator = this.facade.retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator;
			if (appMediator)
				return appMediator.mainCanvas.stage
			return null
		}
		
		protected function loginHandler(success:Object, fail:Object):void
		{
			if (success != null)
				trace("success:\n"+JSON.stringify(success));
			if (fail != null)
				trace("failed:\n"+JSON.stringify(fail));
		}
		
		
		public function login():void
		{
			var stage:Stage = getAppStage();
			var stageWebView:StageWebView = new StageWebView()
			stageWebView.stage = stage;
			stageWebView.viewPort = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			FacebookMobile.login(loginHandler, stage, ['read_stream', 'create_event', 'publish_actions'], stageWebView);
		}
		
		public function get token():String
		{
			return $token;
		}
		
		public function FacebookProxy()
		{
			super(NAME, null);
		}
	}
}