进度条关闭
import com.skynetsoft.events.ProgressBarEnableEvent;
dispatchEvent(new ProgressBarEnableEvent(ProgressBarEnableEvent.DISABLE));

进度条打开
import com.skynetsoft.events.ProgressBarEnableEvent;
dispatchEvent(new ProgressBarEnableEvent(ProgressBarEnableEvent.ENABLE));

注意进度条的打开和关闭操作不允许放在第一帧上。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

交互跳转样例

import flash.events.Event;
import com.skynetsoft.events.LoaderEvent;
import com.skynetsoft.events.FrameLabelEvent;

/* 显示对象
显示指定的元件实例。

说明:
1. 使用此代码显示当前隐藏的对象。
*/

button_1.visible = true;


button_1.addEventListener(MouseEvent.CLICK, on_MouseClickHandler_skip);

function on_MouseClickHandler_skip(event:MouseEvent):void
{

	var pEvt:FrameLabelEvent = new FrameLabelEvent(FrameLabelEvent.FRAME_LABEL_SKIP);
	pEvt.frameLabel = "A003";
	dispatchEvent(pEvt);
	// 开始您的自定义代码
	// 此示例代码在"输出"面板中显示"已单击鼠标"。
	trace("标签跳跃事件");
	// 结束您的自定义代码
}


button4Play.addEventListener(MouseEvent.CLICK, on_MouseClickHandler_Play);

function on_MouseClickHandler_Play(event:MouseEvent):void
{
	
	var pEvt:LoaderEvent = new LoaderEvent(LoaderEvent.REPLAY);
	dispatchEvent(pEvt);
	// 开始您的自定义代码
	// 此示例代码在"输出"面板中显示"已单击鼠标"。
	trace("抛出继续播放的事件");
}


button4Pause.addEventListener(MouseEvent.CLICK, on_MouseClickHandler_Pause);

function on_MouseClickHandler_Pause(event:MouseEvent):void
{
	var pEvt:LoaderEvent = new LoaderEvent(LoaderEvent.PAUSE);
	dispatchEvent(pEvt);
	trace("抛出暂停播放的事件");
}


