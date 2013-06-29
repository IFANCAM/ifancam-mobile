package com.ifancam.iFanCamApp.commands
{
	import flash.system.Security;
	import flash.system.SecurityPanel;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.utilities.statemachine.FSMInjector;
	
	public class StartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var fsm:XML =  <fsm initial={ApplicationFacade.ACTION_LOGIN}>
							   <state name={ApplicationFacade.STATE_LOGIN} entering={ApplicationFacade.ENTER_LOGIN} exiting={ApplicationFacade.EXIT_LOGIN}>
								<transition action={ApplicationFacade.ACTION_MAIN} target={ApplicationFacade.STATE_MAIN} />	
							   </state>
							   <state name={ApplicationFacade.STATE_MAIN} entering={ApplicationFacade.ENTER_MAIN} exiting={ApplicationFacade.EXIT_MAIN}>
								<transition action={ApplicationFacade.ACTION_BROADCAST} target={ApplicationFacade.STATE_BROADCAST} />
								<transition action={ApplicationFacade.ACTION_LOGIN} target={ApplicationFacade.STATE_LOGIN} />
							   </state>
							   <state name={ApplicationFacade.STATE_BROADCAST} entering={ApplicationFacade.ENTER_BROADCAST} exiting={ApplicationFacade.EXIT_BROADCAST}>
								<transition action={ApplicationFacade.ACTION_MAIN} target={ApplicationFacade.STATE_MAIN} />							   
							   </state>
							</fsm>;
			
			
			var injector:FSMInjector = new FSMInjector( fsm );
			injector.initializeNotifier( this.multitonKey );
			injector.inject();
			
			Security.showSettings(SecurityPanel.PRIVACY);
		}
		
		public function StartupCommand()
		{
			super();
		}
	}
}