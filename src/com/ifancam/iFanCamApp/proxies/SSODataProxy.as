package com.ifancam.iFanCamApp.proxies
{
	import com.ifancam.iFanCamApp.vo.SSODataVO;
	import com.webfreshener.core.proxies.SharedObjectProxy;
	import com.webfreshener.core.utils.Base64Codec;
	
	public class SSODataProxy extends SharedObjectProxy
	{
		override public function onRegister():void
		{
			super.onRegister()
			if ($so)
				this.setData(decodeData());
		}
		
		protected function decodeData():SSODataVO
		{
			var vo:SSODataVO;
			var decoded:Object;
			
			if (this.$so.data == null)
				return (null)
				
			decoded = Base64Codec.decodeObject(this.$so.data);
			vo =  SSODataVO(decoded);
			if (vo == null){
				try {
					vo = SSODataVO(decoded);
				}
				catch(e:Error) {
					trace("[SSODataProxy] getServerSetting Caught Error: " + e.message);
				}
			}
			return vo;
		}
		
		
		public function get authData():SSODataVO
		{
			return this.getData() as SSODataVO;
		}
		
		
		public function SSODataProxy(name:String, data:Object=null)
		{
			super(name, data);
		}
	}
}