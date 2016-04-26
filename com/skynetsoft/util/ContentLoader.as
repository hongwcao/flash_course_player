package  com.skynetsoft.util{
	import flash.display.Loader;
	import flash.display.Shape;
	import com.skynetsoft.util.Constant;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.None;
	import fl.transitions.TweenEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.skynetsoft.events.ProgressMouseEvent;
	import com.skynetsoft.events.LoaderEvent;
	import com.skynetsoft.cmi.scorm.LessonStatus;
	import com.skynetsoft.events.FrameLabelEvent;
	import flash.net.URLLoader;
	import com.skynetsoft.util.HashMap;
	import com.skynetsoft.util.SubtitleType;
	import com.skynetsoft.events.ProgressBarEnableEvent;
	import com.skynetsoft.events.CategoryTitleRefreshEvent;
	import com.skynetsoft.events.LicenseDefineEvent;
	import com.skynetsoft.events.SubtitleEnableEvent;

	//内容加载服务类
	public class ContentLoader extends Loader {
        //Security.allowDomain('*');
		private var _label:String;
		private var _url:String;
		private var _path:String;
		private var _code:String;
		private var _key:String;		
		private var _content:MovieClip;
		private var _progressBar:ProgressBar = new ProgressBar();
		private var _timer:Timer;
		private var _soundLoader:SoundLoader;
		private var _soundReadyForPlay:Boolean = false;
		private var _contentReadyForPlay:Boolean = false;
		private var _subtitleReadyForPlay:Boolean = false;
		private var _language:String;
		private var _oriFrameLabel:String ="-1";
		private var _frameLabel:String = "";
		private var _subtitleLoader:URLLoader;
		private var _subtitle:XML;
		private var _subtitleMap:HashMap;
		private var _isRegProgressBar:Boolean = false;
		
		private function set subtitleMap(m:HashMap):void{
			   _subtitleMap = m;
			}
		private function get subtitleMap():HashMap{
			   return _subtitleMap;
			}	
		
		private function set subtitle(x:XML):void{
			  _subtitle = x;
			}
		private function get subtitle():XML{
			  return _subtitle;
			}
		private function set subtitleReadyForPlay(b:Boolean):void{
			    _subtitleReadyForPlay = b; 
			}
		private function get subtitleReadyForPlay():Boolean{
			    return _subtitleReadyForPlay;
			}	
		private function set subtitleLoader(_loader:URLLoader):void{
			    _subtitleLoader = _loader;
			}
		private function get subtitleLoader():URLLoader{
			    return _subtitleLoader;
			}	
		private function set frameLabel(f:String):void{
			  _frameLabel = f;
			}
		private function get frameLabel():String{
			  return _frameLabel;
			}	
		
		private function setLabel(label:String):void{
			_label = label;
		}
		private function getLabel():String{
			  return _label;
			}
		private function setPath(path:String):void{
			  _path = path;
			}
		private function getPath():String{
			  return _path;
			}
		private function setOriFrameLabel(ob:String){
			   _oriFrameLabel = ob;
			}
		private function getOriFrameLabel():String{
			  return _oriFrameLabel;
			}
		
		private function setLanguage(ob:String){
			  _language = ob;
			}
		private function getLanguage():String{
			   return _language;
			}	
		
		private function getSoundReady():Boolean{
			  return _soundReadyForPlay;
			}
		private function getContentReady():Boolean{
			  return _contentReadyForPlay;
			}	
		private function setSoundReady(ob:Boolean){
			   _soundReadyForPlay = ob;
			}	
		private function setContentReady(ob:Boolean){
			   _contentReadyForPlay = ob;
			}	
		private function getKey():String{
			  return _key;
			}
		private function setKey(ob:String):void{
			  _key = ob;
			}	
		private function getTimer():Timer{
			   return _timer;
			}
		private function setTimer(ob:Timer){
			   _timer = ob;
			}	
		public function getProgressBar():ProgressBar{
			   return _progressBar;
			}
		private function setProgressBar(ob:ProgressBar){
			   _progressBar = ob;
			}	
		private function getContent():MovieClip{
			  return _content;
			}
		private function setContent(ob:MovieClip){
			  _content = ob; 
			}	
		private function getURL():String{
			  return _url;
			}
		private function setURL(url:String){
			  _url = url;
			} 
		private function setCode(code:String){
			  _code = code;
			}	
		private function getCode():String {
			  return _code;
			}	
		private function getCodeURL():String{
			  return Constant.CONTENT_DIR + "/" + getURL() + "."+ getLanguage() +"."+ getCode();
			}
		private function getSubtitleURL():String{
			  return Constant.CONTENT_DIR + "/" + getURL() + ".sub." + getLanguage() + "." + "xml";
			}	
		private function setSoundLoder(ob:SoundLoader):void{
			  _soundLoader = ob;
			}	
		private function getSoundLoder():SoundLoader{
			  return _soundLoader;
			}
		private function getSound(_ob:SoundLoader):MovieClip{
			  return _ob.content as MovieClip
			}	
		
		//获取默认的遮罩
		private function setDefaultMask(ob:ContentLoader){
			   var rect:Shape = new Shape();
               rect.graphics.beginFill(0xFFFFFF);
               rect.graphics.drawRect(ob.x, ob.y,Constant.DEFAULT_WIDTH,Constant.DEFAULT_HEIGHT);
               ob.mask = rect;
			}	
		//响应外部模块，控制内容的暂停
		public function onPause(evt:PanelStatusEvent){
				contentStop();
			}	
		//响应外部模块，控制内容的播放
		public function onReplay(evt:PanelStatusEvent){
				//判断语音或者语言状态是否被修改过
				if (isURLChanged()) {
					//do nothing
				} else {
					contentPlay();
				}
			}	
		//派发语言状态被改动事件
		private function onLanguageChange():void{
			    var evt:LoaderEvent = new LoaderEvent(LoaderEvent.LANGUAGE_ONCHANGE);
				evt.key = this.getKey();
				dispatchEvent(evt);
			};
		
        //检查语言或者语音是否被更改过 true表示修改过则需要进行相应的处理，false表示未修改
		private function isURLChanged():Boolean{
			   var result:Boolean = false;
			   var oriContentURL:String = getCodeURL();
			   var currContentURL:String = Constant.CONTENT_DIR + "/"+getURL() + "."+ Constant.getCurrentLanguage() +"."+ getCode();
			   var oriAudioURL:String = getSoundLoder().getCodeURL();
			   var currAudioURL:String =  Constant.SOUND_DIR + "/"+getURL() + ".sound."+Constant.getCurrentSpeakAudio()+"."+getCode(); 
			   //判断是否语言被切换过
			   if (oriContentURL != currContentURL) {
					   this.setContentReady(false);
					   setLanguage(Constant.getCurrentLanguage());
					   this.setOriFrameLabel(getContent().currentFrame.toString());
					   onLanguageChange();
					   reloadVideo(getURL(),getCode(),getKey(),getLanguage());
					   //loadURL(getCodeURL());
					   result = true;
					   
				   } else {
					     this.setContentReady(true);
					   }
			   if (oriAudioURL != currAudioURL) {
				       this.setSoundReady(false);
					   this.getSoundLoder().setSpeakAudio(Constant.getCurrentSpeakAudio());
					   this.setOriFrameLabel(getContent().currentFrame.toString());
					   reloadAudio(getURL(),getCode(),getKey(),this.getSoundLoder().getSpeakAudio());
					   //this.getSoundLoder().loadURL(this.getSoundLoder().getCodeURL());
					   result = true;
				   } else {
					     this.setSoundReady(true);
					   }
				return result;   
			}
		//公共播放函数
        public function contentPlay():void{
			   trace("content play!");
			   this.setSoundReady(false);
			   this.setContentReady(false); 
			   var evt:LicenseDefineEvent  = new LicenseDefineEvent(LicenseDefineEvent.LICENSE_DEFINE);
			   getContent().dispatchEvent(evt);
			   getContent().play();
			   //trace("video frame is "+getContent().currentFrame);
			   getSound(getSoundLoder()).play();
			   //trace("audio frame is "+getSound(getSoundLoder()).currentFrame);
			}
		//公共停止函数
		public function contentStop():void{
			   getContent().stop();
			   getSound(getSoundLoder()).stop();
			}
		//公共跳转播放函数	
		public function contentGotoPlay(_frame:String,_scene:String=null){
			   this.setOriFrameLabel("-1");
			   getContent().gotoAndPlay(_frame,_scene);
			   var evt:LicenseDefineEvent  = new LicenseDefineEvent(LicenseDefineEvent.LICENSE_DEFINE);
			   getContent().dispatchEvent(evt);
			   getSound(getSoundLoder()).gotoAndPlay(_frame,_scene);
			}	
		//公共跳转停止函数
		public function contentGotoStop(_frame:String,_scene:String=null){
			  this.setOriFrameLabel("-1");
			  getContent().gotoAndStop(_frame,_scene);
			  getSound(getSoundLoder()).gotoAndStop(_frame,_scene);
			}	

//-------------------------------------------------------------------------------------------------
// onLoad 事件响应
       //将字幕信息装载入 subtitleMap 对象中
	   private function onSubtitleLoaded(e:Event):void{
			    this.frameLabel = "";
				this.subtitleMap = new HashMap();
				this.subtitle = new XML(this.subtitleLoader.data);
				for each (var prop:XML in this.subtitle..section){
				    var _st:SubtitleType = new SubtitleType(); 
					_st.subtitle = prop;
					_st.label = prop.@label;
					_st.type = prop.@type;
					this.subtitleMap.put(_st.label,_st);
				 }
				onSubtitleLoaderReady();
			}	

		private function onOpen(evt:Event):void{
			
			}
		private function onInit(evt:Event):void{
			 //trace('子场景' + this.contentLoaderInfo.width + ' x ' + this.contentLoaderInfo.height);
             //trace('主场景' + stage.stageWidth + 'x ' + stage.stageHeight);
             //trace('元件' + this.width + 'x' +this.height);
			 //场景比：   本场景大小/被加载文件场景大小
             //trace(evt.currentTarget);
			 
			 setContent(this.content as MovieClip);
			 getContent().stop();
			 autoScreenSize(this);
			 this._isRegProgressBar = false;
			 //trace("ContentLoader is ready");
			/* var tw = stage.stageWidth/this.contentLoaderInfo.width;
             var th = stage.stageHeight/this.contentLoaderInfo.height;
             var tx = tw<th?tw:th;
             //trace('主场景/场景 比例：' + tx);
 
             //缩放比：  被加载场景/被加载文件
             var sw = this.contentLoaderInfo.width/this.width;
             var sh = this.contentLoaderInfo.height/this.height;
			 if ((this.width > Constant.DEFAULT_WIDTH) && (this.height > Constant.DEFAULT_HEIGHT)) {
				 this.width  = this.width*tx;
                 this.height = this.height*tx;
			 }*/
			 addScriptToContent(getContent());
			 if (this.getCode() == CodeType.SWF) {
			     //初始化载入的外部课程
				 initContentSwf(getContent());
				 //初始化进度条
				 initProgressBar(this);
				 //进度条初始化后,需要针对课件内容的事件注册处理
				 regContentEvt4ProgressBar(getContent());
			 }
			 onContentLoaderReady();
			 //this.contentPlay();
			 //todo 对播放进度条的控制
			
			 //(this.content as MovieClip).addChild(_progressBar);
			 
             //绘制遮罩
/*             var rect:Shape = new Shape();
             rect.graphics.beginFill(0xFFFFFF);
             rect.graphics.drawRect(0, 0, ldr.contentLoaderInfo.width*tx, ldr.contentLoaderInfo.height*tx);
             addChild(rect);
             ldr.mask = rect;*/
			}
//end onLoad 事件
//-----------------------------------------------------------------------------------------------------------------
			
//---------------------------------------------------------------------------------------------
//add script to content
		
		//添加脚本代码至外部的播放内容对象上
		private function addScriptToContent(_ob:MovieClip):void{
			  //在导入的content中第一帧及最后一帧添加stop()的代码
			  _ob.addFrameScript(0,addScriptStop,_ob.totalFrames-1,addScriptStop);
			  //只要播放超过最后第2帧则标识该页面以及浏览过的学习状态
			  _ob.addFrameScript(_ob.totalFrames-2,addLessonBrowsed);
			  
			  addLabelChanged();
			  //_ob.addFrameScript(1,addLabelChanged);
			  
			}
		//侦听每帧的变化	
		private function addLabelChanged():void{
			  getContent().addEventListener(Event.ENTER_FRAME,isLabelChanged);
			  
			}	
		//是否标签发生变化的监控函数	
		private function isLabelChanged(evt:Event):void{
			    //监控标签label
				if (this.frameLabel != getContent().currentLabel) {
				      //trace(getContent().currentLabel);
					  this.frameLabel = getContent().currentLabel;
					  onLabelChanged(this.frameLabel);
				   }
				//监控是否影片已经播放至最后   
				if (getContent().currentFrame == getContent().totalFrames) {
					  if (getContent().isPlaying) {
					     onContentEndedHandler();
					  }
					}
				evt.stopImmediatePropagation();   
			}
		
		//影片播放至结束时触发事件	
	    private function onContentEndedHandler():void{
			  trace("视频播放结束");
			  var e:FrameLabelEvent = new FrameLabelEvent(FrameLabelEvent.FRAME_LABEL_ENDED);
			  dispatchEvent(e);
        }	
			
			
		//抛出标签发生变动的事件	
		private function onLabelChanged(_label:String):void{
			   var e:FrameLabelEvent = new FrameLabelEvent(FrameLabelEvent.FRAME_LABEL_CHANGED);
			   if (((this.subtitleMap.get(_label as String)) as SubtitleType) != null) {
			      var _s:SubtitleType = (this.subtitleMap.get(_label as String)) as SubtitleType;
    			  e.subtitle =  _s.subtitle;
			      e.subType = _s.type;
				  e.frameLabel = _s.label;
			   } else {
				   e.subtitle = "";
				   e.subType = "";
				   e.frameLabel = _label;
			   }
			   dispatchEvent(e);
			}	
		private function addScriptStop():void{
			  getContent().stop();
            }
		private function addLessonBrowsed():void{
			  var evt:LoaderEvent = new LoaderEvent(LoaderEvent.LESSON_STATUS_ONCHANGE);
			  evt.lessonStatus = LessonStatus.BROWSED;
			  evt.key = Constant.getCurrentKey();
			  
			  dispatchEvent(evt);
			}	

//end and script to content
//----------------------------------------------------------------------------------------------------



		//根据内容自动调整舞台窗口的尺寸
		private function autoScreenSize(_ob:ContentLoader):void{
			 var tw = stage.stageWidth/_ob.contentLoaderInfo.width;
             var th = stage.stageHeight/_ob.contentLoaderInfo.height;
             var tx = tw<th?tw:th;
             //trace('主场景/场景 比例：' + tx);
 
             //缩放比：  被加载场景/被加载文件
             var sw = _ob.contentLoaderInfo.width/_ob.width;
             var sh = _ob.contentLoaderInfo.height/_ob.height;
			 if ((_ob.width > Constant.DEFAULT_WIDTH) && (_ob.height > Constant.DEFAULT_HEIGHT)) {
				 _ob.width  = _ob.width*tx;
                 _ob.height = _ob.height*tx;
			 } 
			}
		private function readyForPlay():void{
			
			}	
		
		private function onProgressMouseClick(evt:ProgressMouseEvent){
				this.contentGotoPlay(evt.getStageX().toString());
			}
		//注册在播放控制进度条上的侦听事件
		private function regEventsOnProgressBar(ob:ProgressBar){
			    //侦听鼠标点击事件
				ob.addEventListener(ProgressMouseEvent.CLICK, onProgressMouseClick);
				//侦听暂停键鼠标点击事件
				ob.addEventListener(ProgressMouseEvent.PAUSE_BUTTON_CLICK,onPauseMouseClick);
				//侦听播放键鼠标点击事件
				ob.addEventListener(ProgressMouseEvent.PLAY_BUTTON_CLICK,onPlayMouseClick);
				//侦听鼠标移出事件
				ob.addEventListener(ProgressMouseEvent.MOUSE_OUT,onProgressBarMouseOut);
				//侦听鼠标移入事件
				ob.addEventListener(ProgressMouseEvent.MOUSE_OVER,onProgressBarMouseOver);
			}
		
		private function onProgressBarMouseOver(evt:ProgressMouseEvent){
			       if (getProgressBar().alpha == 0){
						  showProgressBar(getProgressBar());
					   }
			}
		private function onProgressBarMouseOut(evt:ProgressMouseEvent){
					if (getProgressBar().alpha == 1){	
						delayHideProgressBar();
					  } 
			}
		//延迟隐藏播放控制进度条
		private function delayHideProgressBar(){
			   //判断定时器是否在运行
			   if (!(getTimer() == null)){
				     if (getTimer().running) {
			             getTimer().stop();
			             }   
				   }
				setTimer(new Timer(Constant.DELAY_TIME,1));
			    getTimer().addEventListener(TimerEvent.TIMER,onTimeHideProgressBar);//注意，事件timer必须全部小写
                getTimer().start();   
			   }

		//定时触发隐藏播放控制进度条
		private function onTimeHideProgressBar(evt:Event){
					hideProgressBar(getProgressBar());
			}	
		//显示播放控制进度条
		private function showProgressBar(_progressBar:ProgressBar){
				    var tw:Tween = new Tween(_progressBar,"alpha",None.easeInOut,_progressBar.alpha,1,Constant.MOTION_DIALOG_SPEED,true);
			}  
		//隐藏播放控制进度条
		private function hideProgressBar(_progressBar:ProgressBar){
			    var tw:Tween = new Tween(_progressBar,"alpha",None.easeInOut,_progressBar.alpha,0,Constant.MOTION_DIALOG_SPEED,true);
				tw.stop();
				//tw.addEventListener(TweenEvent.MOTION_FINISH,onHideProgressBarFinish);
				tw.start();
			}	

		private function onPauseMouseClick(evt:ProgressMouseEvent){
			    this.contentStop();
				//this.getContent().stop();
				
			}
		private function onPlayMouseClick(evt:ProgressMouseEvent){
			    this.contentPlay();
				//this.getContent().play();
				
			}	
		private function initContentSwf(ob:MovieClip):void{
			   ob.addEventListener(LoaderEvent.PAUSE, onLoaderPause);
			   ob.addEventListener(LoaderEvent.REPLAY,onLoaderReplay);
			   ob.addEventListener(FrameLabelEvent.FRAME_LABEL_SKIP,onLoaderSkip);
			   
			}	
		private function regContentEvt4ProgressBar(ob:MovieClip):void{
			   trace("regContentEvt4ProgressBar");
			   ob.addEventListener(ProgressBarEnableEvent.ENABLE,getProgressBar().onProgressBarEnable);
			   ob.addEventListener(ProgressBarEnableEvent.DISABLE,getProgressBar().onProgressBarDisable);
			   //ob.addEventListener(ProgressBarEnableEvent.DISABLE,onTestProgress);
			   this._isRegProgressBar = true;
			   
			}
		private function onTestProgress(evt:ProgressBarEnableEvent):void{
			   trace(evt);
			   evt.stopImmediatePropagation();
			}
		
		private function onLoaderSkip(evt:FrameLabelEvent):void{
			   this.contentGotoPlay(evt.frameLabel);
			}	
		private function onLoaderPause(evt:LoaderEvent):void{
			   this.getProgressBar().raisePauseEvent();
			}
		private function onLoaderReplay(evt:LoaderEvent):void{
			   this.getProgressBar().raiseReplayEvent();
			}	
		//初始化进度条控件	
		private function initProgressBar(ob:ContentLoader):void{
			   this.parent.removeChildAt(Constant.progressLevel);
			   //重新注入进度条对象
			   setProgressBar(new ProgressBar());
			   getProgressBar().contentOb = this.getContent();
			   //注册事件在进度条控件上
			   regEventsOnProgressBar(getProgressBar());
			   this.parent.addChildAt(getProgressBar(),Constant.progressLevel);
 			}
		private function onProgress(evt:ProgressEvent):void{
			   //获取当前加载的完成百分比
			   var ob:Number = Math.round((evt.bytesLoaded/evt.bytesTotal)*100);
			}	
//----------------------------------------------------------------------------------------		
//external interface for public
		//响应目录树的对象内容载入事件	
		public function onCategoryReload(evt:CategoryEvent):void{
			   //设置语言
			   setURL(evt.getURL());
			   setCode(evt.getCode());
			   setKey(evt.getKey());
			   setPath(evt.getPath());
			   setLabel(evt.getLabel());
			   //设置语音
			   this.getSoundLoder().setCode(evt.getCode());
			   this.getSoundLoder().setURL(evt.getURL());
			   this.getSoundLoder().setKey(evt.getKey());
			   evt.stopImmediatePropagation();
			   
			   reloadMovie();
			   //reloadVideo(evt.getURL(),evt.getCode(),evt.getKey());
			}
		
		//支持外部程序重载功能按钮
		public function reloadContent(evt:MouseEvent){
			  reloadMovie();
			  //reloadVideo(getURL(),getCode(),getKey(),getLanguage());    
			  //reloadAudio(this.getSoundLoder().getURL(),this.getSoundLoder().getCode(),this.getSoundLoder().getKey(),this.getSoundLoder().getSpeakAudio());
			}
		//载入内容,包括视频和音频
		private function reloadMovie(){
			  reloadVideo(getURL(),getCode(),getKey(),getLanguage());    
			  reloadAudio(this.getSoundLoder().getURL(),this.getSoundLoder().getCode(),this.getSoundLoder().getKey(),this.getSoundLoder().getSpeakAudio());
			}
		
		//载入外部文件的内容对象
		public function reloadVideo(_url:String=Constant.DEF_URL,_code:String=Constant.DEF_CODE,_key:String=Constant.DEF_KEY,_language:String=LocalType.CN):void{
			   this.setContentReady(false);
			   this.setURL(_url);
			   this.setCode(_code);
			   this.setKey(_key);
			   this.setLanguage(_language);
			   Constant.setCurrentKey(_key);
			   reloadSubtitle();
			   loadURL(getCodeURL()); 
			  
			}
				//加载外部文件的语音对象	
		public function reloadAudio(_url:String=Constant.DEF_URL,_code:String=Constant.DEF_CODE,_key:String=Constant.DEF_KEY,_speakAudio:String=LocalType.CN):void{
			   this.setSoundReady(false);
			   this.getSoundLoder().reload(_url,_code,_key,_speakAudio);
			}	
		//载入外部字幕文件
		private function reloadSubtitle():void{
				this.subtitleReadyForPlay = false;
				var url:URLRequest = new URLRequest(this.getSubtitleURL());
				subtitleLoader.load(url);
            }

		private function loadURL(_url:String){
			  var urlReq:URLRequest = new URLRequest(_url);
			  this.unloadAndStop();
			  //for url testing
			  //onRefreshTitle(_url);
			  this.load(urlReq);
			}	

//------------------------------------------------------------------------------------------------			
		//初始化默认的外部文件信息
		public function initParams(_url:String=Constant.DEF_URL,_code:String=Constant.DEF_CODE,_key:String=Constant.DEF_KEY,_language:String=LocalType.CN):void{
			   this.setURL(_url);
			   this.setCode(_code);
			   this.setKey(_key);
			   this.setLanguage(_language);
			}
		private function initSoundLoader(_ob:SoundLoader):void{
			   this.setSoundLoder(_ob);
			}	
				//字幕装载器
		private function initSubtitleLoader(){
			   this.subtitleLoader = new URLLoader();
			}	
		

//------------------------------------------------------------------------------------
// sync for play

		//语音与内容播放进行同步
		private function onSoundLoaderReady(evt:LoaderEvent):void{
				this.setSoundReady(true);
				if (this.getContentReady() && this.subtitleReadyForPlay ) {
					  if (this.getOriFrameLabel() == "-1") {
					  this.contentPlay();
					  } else {
					  this.contentGotoPlay(this.getOriFrameLabel()); 
					  }
					  //getContent().addChild(getProgressBar());
					}
			}
		//语音与内容播放进行同步
		private function onContentLoaderReady():void{
				this.setContentReady(true);
				if (!this._isRegProgressBar) {return;}
				if (this.getSoundReady() && this.subtitleReadyForPlay) {
					  if (this.getOriFrameLabel() == "-1") {
					  this.contentPlay();
					  } else {
					  this.contentGotoPlay(this.getOriFrameLabel()); 
					  }
					 //bug
					 //getContent().addChild(getProgressBar());
					}
			}	
		private function onSubtitleLoaderReady():void{
			   this.subtitleReadyForPlay = true;
			   if (!this._isRegProgressBar){return;}
			   if (this.getSoundReady() && this.getContentReady()) {
				      if (this.getOriFrameLabel() == "-1") {
					  this.contentPlay();
					  } else {
					  this.contentGotoPlay(this.getOriFrameLabel()); 
					  }
					  //getContent().addChild(getProgressBar());
				   }
			}
// end sync for play
//-------------------------------------------------------------------------------------------------------			
		 
		
		//注册loader的侦听事件
		private function registerEvents(ob:ContentLoader){
			  //注册在加载操作开始时的事件调度
			  ob.contentLoaderInfo.addEventListener(Event.OPEN,onOpen);
			  //注册当已加载的 SWF 文件的属性和方法可供访问并做好使用准备时进行调度
			  ob.contentLoaderInfo.addEventListener(Event.INIT,onInit);
			  //在下载操作过程中收到数据时调度。
			  ob.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
			  //注册语音载入器,ready for play事件
			  ob.getSoundLoder().addEventListener(LoaderEvent.READY_FOR_PLAY,onSoundLoaderReady);
			  //注册字幕载入器，complete事件
			  ob.subtitleLoader.addEventListener(Event.COMPLETE,onSubtitleLoaded); 
			}
		

		//content对象的构造函数
		public function ContentLoader() {
			this.x = Constant.CONTENT_X;
			this.y = Constant.CONTENT_Y;
			this.filters = new Array(Constant.getDefaBtnDpShadow());
			//todo 获取配置信息均从服务器上获取，则这里需要进行异步获取信息异步处理
			initParams();
			initSoundLoader(new SoundLoader());
			initSubtitleLoader();
			registerEvents(this);
			setDefaultMask(this);
			//加载内容对象
			//reloadVideo();
			//加载语音对象
			//reloadAudio();
			
		}	
		private function onRefreshTitle(label:String){
			var _evt:CategoryTitleRefreshEvent = new CategoryTitleRefreshEvent(CategoryTitleRefreshEvent.ON_REFRESH);
			_evt.setTitleText(label);
			trace("label is "+label);
			dispatchEvent(_evt);
			}	

	}
	
}
