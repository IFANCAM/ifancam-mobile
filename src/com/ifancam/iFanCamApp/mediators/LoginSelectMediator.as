package com.ifancam.iFanCamApp.mediators
{
	import com.ifancam.iFanCamApp.vo.NavigationNoteVO;
	import com.webfreshener.core.utils.InteractionEventUtil;
	
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	
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
			trace("LoginSelectMediator registered");
			view.loginBttn.addEventListener(TouchEvent.TOUCH_END, onLoginTouched, false, 0, true);
			view.loginBttn.addEventListener(MouseEvent.CLICK, onLoginClicked, false, 0, true);
		}
		
		protected function onLoginClicked(event:MouseEvent):void
		{
			showSignIn()
		}
		
		protected function onLoginTouched(event:TouchEvent):void
		{
			showSignIn();
		}
		
		
		public function showSignIn():void
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