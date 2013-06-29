package com.ifancam.iFanCamApp.vo
{
	import spark.transitions.ViewTransitionBase;

	public class NavigationNoteVO
	{
		public var viewCLass:Class;
		public var context:Object = null;
		public var data:Object = null;
		public var transition:ViewTransitionBase = null;
	}
}