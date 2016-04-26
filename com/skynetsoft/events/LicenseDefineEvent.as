package com.skynetsoft.events {
	import flash.events.Event;

	//定义许可证事件
	public class LicenseDefineEvent extends Event {
        public static const LICENSE_DEFINE = "License_Define_Event";
		//定义默认的key
		public static const LICENSE_KEY:String = "ED1932FC-0EEB-4416-8F67-B21C849145C3";
		//定义版本
		private var _mainFrameVersion:String;
		//定义访问密码
		private var _password:String;
		//定义可访问的资源权限
		private var _access:String;
		
		public function LicenseDefineEvent(evtType:String) {
			super(evtType);
		}
		public function get mainVersion():String{
			return _mainFrameVersion;
		}
		public function set mainVersion(_ver:String):void{
			_mainFrameVersion = _ver;
		}
		public function get password():String{
		    return _password;
		}
		public function set password(_pwd:String):void{
			_password = _pwd;
		}
		public function get access():String{
		    return _access;
		}
		public function set access(_acc:String):void{
			_access =  _acc;
		}
   }
	
}
