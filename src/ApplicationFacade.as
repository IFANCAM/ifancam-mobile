package
{	
	import com.ifancam.iFanCamApp.commands.ShutdownCommand;
	import com.ifancam.iFanCamApp.commands.StartupCommand;
	import com.ifancam.iFanCamApp.mediators.ApplicationMediator;
	import com.webfreshener.core.types.InteractionMode;
	import com.webfreshener.core.utils.InteractionEventUtil;
	
	import spark.components.Application;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * 
	 * @author van
	 * 
	 */	
	public class ApplicationFacade extends Facade implements IFacade
	{
		public static const NAME:String 						= "iFanCam";
		/*
		*
		* Application Settings
		*
		*/
		
		
		//-- enable/disable trace output
		public static var DEBUG:Boolean							= true;
		
		
		public static const FACEBOOK_APP_KEY:String				= "672518372774372";
		public static const FACEBOOK_APP_SECRET:String			= "c2492eb79ec17fb026574037d73ea356";
	
		/*
		*
		* PureMVC Notification Types
		*
		*/		
		
		public static const INIT_STATES:String          		= "notes/InitStates";
		
		
		public static const NAVIGATION_NOTE:String				= "notes/navigation";
		public static const NAVIGATION_TYPE_PUSH:String			= "types/navigationPush";
		public static const NAVIGATION_TYPE_POP:String			= "types/navigationPop";
		
		
		
		public static const CHANGE_VIEW_INDEX:String			= "notes/changeViewIndex";
		
		public static const USER_SIGNIN:String					= "notes/userSignin";
		public static const DATA_LOADED:String					= "notes/dataLoaded";
		public static const DATA_ERROR:String					= "notes/dataError";
		
		public static const CREATE_POPUP:String					= "notes/createPopUp";
		
		public static const USER_STATUS_DATA_AVAILABLE:String	= "notes/DataAvailable";
		
		public static const CHAT_SESSION_NOTE:String			= "notes/chatSession"
		public static const CHAT_MESSAGE_NOTE:String			= "notes/chatMessage"
		public static const CHAT_MESSAGE_TYPE_RCVD:String 		= "types/chatMessageRcvd";
		public static const CHAT_MESSAGE_TYPE_SEND:String		= "types/chatMessageSend";		
		public static const CHAT_MESSAGE_TYPE_SUCCESS:String 	= "types/chatMessageSuccess";
		public static const CHAT_MESSAGE_TYPE_ERROR:String 		= "types/chatMessageError";
		

		public static const NET_SESSION_NOTE:String				= "notes/netSessionNote";
		public static const NET_SESSION_TYPE_START:String		= "types/netSessionStart";
		public static const NET_SESSION_TYPE_END:String			= "types/netSessionEnd";
		
		public static const NET_STATUS_NOTE:String				= "notes/netStatusNote";
		public static const NET_STATUS_TYPE_ASYNCERROR:String	= "types/netStatusTypeAsyncError";
		public static const NET_STATUS_TYPE_CLOSED:String		= "types/netStatusTypeClosed";
		public static const NET_STATUS_TYPE_FAILED:String		= "types/netStatusTypeFailed";
		public static const NET_STATUS_TYPE_INVALIDAPP:String	= "types/netStatusTypeInvalidApp";
		public static const NET_STATUS_TYPE_NETCHANGE:String	= "types/netStatusTypeNetworkChange";
		public static const NET_STATUS_TYPE_REJECTED:String		= "types/netStatusTypeRejected";
		public static const NET_STATUS_TYPE_SUCCESS:String		= "types/netStatusTypeSuccess";
		public static const NET_STATUS_TYPE_SHUTDOWN:String		= "types/netStatusTypeShutdown";
		public static const NET_STATUS_TYPE_TIMEOUT:String		= "types/netStatusTypeTimeout";

		public static const PLAY_STATUS_NOTE:String				= "notes/playStatusNote";
		public static const PLAY_STATUS_TYPE_BADNAME:String		= "types/playStatusTypeBadName";
		public static const PLAY_STATUS_TYPE_CONNECT:String		= "types/playStatusConnect";
		public static const PLAY_STATUS_TYPE_IDLE:String		= "types/playStatusTypeIdle";
		public static const PLAY_STATUS_TYPE_START:String		= "types/playStatusTypeStart";
		public static const PLAY_STATUS_TYPE_STOP:String		= "types/playStatusTypeStop";
		
		public static const PUBLISH_STATUS_NOTE:String			= "notes/publish";
		public static const PUBLISH_STATUS_TYPE_START:String	= "types/publishStart";
		public static const PUBLISH_STATUS_TYPE_STOP:String		= "types/publishStop";
		public static const PUBLISH_STATUS_TYPE_BADNAME:String	= "types/publishBadName";
		
		public static const SHUTDOWN:String          			= "notes/shutdown";
		public static const STARTUP:String          			= "notes/startup";
		
		public static const SHOW_ALERT_NOTE:String				= "notes/showAlertNote";
		public static const SHOW_ALERT_TYPE_CONNECT_FAIL:String	= "types/showAlertTypeConnectFail";	
		
		public static const ACTION_ONLINE_BROADCASTERS:String	= "actions/onlineBroadcasters";
		
		
		
		/*
		*
		*	FSM STATES
		*
		*/
		public static const STATE_INIT:String					= "init";
		public static const ACTION_INIT:String					= "action/init";
		public static const ENTER_INIT:String					= "enter/init";
		public static const EXIT_INIT:String					= "exit/init";
		
		public static const STATE_LOGIN:String					= "login";
		public static const ACTION_LOGIN:String					= "action/login";
		public static const ENTER_LOGIN:String					= "enter/login";
		public static const EXIT_LOGIN:String					= "exit/login";
		
		public static const STATE_MAIN:String					= "main";
		public static const ACTION_MAIN:String					= "action/main";
		public static const ENTER_MAIN:String					= "enter/main";
		public static const EXIT_MAIN:String					= "exit/main";
		
		public static const STATE_BROADCAST:String				= "broadcast";
		public static const ACTION_BROADCAST:String				= "action/broadcast";
		public static const ENTER_BROADCAST:String				= "enter/broadcast";
		public static const EXIT_BROADCAST:String				= "exit/broadcast";
		
		public static const STATE_VIEWER:String					= "viewer";
		public static const ACTION_VIEWER:String				= "action/viewer";
		public static const ENTER_VIEWER:String					= "enter/viewer";
		public static const EXIT_VIEWER:String					= "exit/viewer";

		public static const STATE_SETTINGS:String				= "settings";
		public static const ACTION_SETTINGS:String				= "action/settings";
		public static const ENTER_SETTINGS:String				= "enter/settings";
		public static const EXIT_SETTINGS:String				= "exit/settings";
		
		
		public static function getInstance( key:String ) : ApplicationFacade 
		{
			if ( instanceMap[ key ] == null ) instanceMap[ key ]  = new ApplicationFacade( key );
			return instanceMap[ key ] as ApplicationFacade;
		}
		
		public function ApplicationFacade(key:String)
		{
			super(key);
			this.registerCommand(STARTUP, StartupCommand);
			this.registerCommand(SHUTDOWN, ShutdownCommand);
		}
		
		protected var _app:Application;
		
		public function get app():Application
		{
			return this._app;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function startup(application:Application):void
		{
			if (DEBUG)
				InteractionEventUtil.MODE = InteractionMode.DUAL;
			this.sendNotification(STARTUP, application);
			this.registerMediator( new ApplicationMediator( application ) );
		}
		
		/**
		 * 
		 * 
		 */		
		public function shutdown():void
		{
			this.sendNotification(SHUTDOWN, this.view as Application);
		}
	}
}