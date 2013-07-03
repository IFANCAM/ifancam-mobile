package com.ifancam.iFanCamApp.mediators
{
	import com.ifancam.iFanCamApp.proxies.FacebookProxy;
	import com.ifancam.iFanCamApp.vo.NavigationNoteVO;
	import com.webfreshener.core.utils.InteractionEventUtil;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import views.LoginSelectView;

	/**
	 * 
	 * @author van
	 * 
	 */	
	public class LoginSelectMediator extends Mediator
	{
		public static const NAME:String = "LoginSelectMediator";
		
		override public function onRegister():void
		{
			super.onRegister()
			InteractionEventUtil.addEventHandler( view.loginBttn, InteractionEventUtil.INTERACTION_CLICK, showSignIn);
			InteractionEventUtil.addEventHandler( view.facebookLoginBttn, InteractionEventUtil.INTERACTION_CLICK, doFacebookLogin);
			InteractionEventUtil.addEventHandler( view.twitterLoginBttn, InteractionEventUtil.INTERACTION_CLICK, doTwitterLogin);
		}
		
		public function doFacebookLogin(event:Event):void
		{
			var proxy:FacebookProxy
			this.facade.registerProxy( proxy = new FacebookProxy );
//			proxy.login();
		}
		
		public function doTwitterLogin(event:Event):void
		{
			
		}

		public function showSignIn(event:Event):void
		{
			var navNote:NavigationNoteVO = new NavigationNoteVO;
			navNote.viewCLass = views.SignInView;
			this.facade.sendNotification( ApplicationFacade.NAVIGATION_NOTE, navNote, ApplicationFacade.NAVIGATION_TYPE_PUSH);
		}
		
		public function get view():LoginSelectView
		{
			return this.viewComponent as LoginSelectView
		}
		
		public function LoginSelectMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
	}
}