package 
{

	import flash.display.MovieClip;
	import com.skynetsoft.events.FrameLabelEvent;
	import flash.events.MouseEvent;


	public class ShowNextMC extends MovieClip
	{

        //构造函数   
		public function ShowNextMC()
		{
			this.x = 887;
			this.y = 693;
			this.gotoAndStop(1);
		}
		
		//执行播放
		public function onExecute(e:FrameLabelEvent):void
		{
			this.gotoAndPlay(1)
		}
		//执行停止播放操作
		public function onStopPlay(e:MouseEvent):void
		{
			this.gotoAndStop(1);
		}

	}

}