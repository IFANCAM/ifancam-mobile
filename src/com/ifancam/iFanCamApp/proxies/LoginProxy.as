package com.ifancam.iFanCamApp.proxies
{
	import com.webfreshener.core.proxies.RequestProxy;
	/**
	 * 
	 * @author van
	 * 
	 */	
	public class LoginProxy extends RequestProxy
	{
		
		public static const NAME:String = "LoginProxy";
		
		
		public function LoginProxy()
		{
			super(NAME, false);
		}
	}
}