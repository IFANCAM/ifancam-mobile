package com.ifancam.iFanCamApp.mediators
{
	import com.ifancam.iFanCamApp.vo.NavigationNoteVO;
	import com.webfreshener.core.view.IPassivelyMediated;
	
	import mx.core.ClassFactory;
	import mx.core.IVisualElement;
	
	import spark.events.ElementExistenceEvent;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	/**
	 * 
	 * @author van
	 * 
	 */	
	public class ApplicationMediator extends Mediator
	{
		public static const NAME:String = "ApplicationMediator";
		
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NAVIGATION_NOTE
				];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getType())
			{
				case ApplicationFacade.NAVIGATION_TYPE_PUSH:
					var note:NavigationNoteVO = notification.getBody() as NavigationNoteVO;
					mainCanvas.navigator.pushView(note.viewCLass, note.data, note.context, note.transition);
					break;
				case ApplicationFacade.NAVIGATION_TYPE_POP:
					mainCanvas.navigator.popView(null);
					break;
			}
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			trace("AppMediator onRegister");
			mainCanvas.addEventListener(ElementExistenceEvent.ELEMENT_ADD, onViewAdded, false, 0, true);
			mainCanvas.addEventListener(ElementExistenceEvent.ELEMENT_REMOVE, onViewRemoved, false, 0, true);
			
			this.registerView( this.mainCanvas.navigator.getElementAt( 0 ) );
			
			
		}
		
		
		protected function registerView(view:IVisualElement):void
		{
			var mediator:IMediator = initContentMediator( IPassivelyMediated(view).mediatorClass ); 
			if (mediator)
			{
				mediator.setViewComponent(view);
				this.facade.registerMediator( mediator );
			};
		}
		
		protected function onViewAdded(event:ElementExistenceEvent):void
		{
			trace("ON View Added");
			this.registerView(event.element);
		}

		protected function onViewRemoved(event:ElementExistenceEvent):void
		{
			this.facade.removeMediator( IPassivelyMediated(event.element).mediatorClass.NAME as String );
		}
		
		
		private function initContentMediator(clazz:Class):IMediator
		{
			var cf:ClassFactory = new ClassFactory(clazz);
			return ((cf.newInstance() as IMediator));
		}
		
		
		public function get mainCanvas():Main
		{
			return this.viewComponent as Main;
		}
		
		
		public function ApplicationMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
	}
}