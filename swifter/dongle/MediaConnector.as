package swifter.dongle {
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	public class MediaConnector extends EventDispatcher {
		private var client:MovieClip;
		private var host:MovieClip;
		public function MediaConnector(hostSWF:MovieClip,clientURL:URLRequest,progressFunction:Function=null) {
			host = hostSWF;
			var loader:Loader = new Loader();
			loader.load(clientURL);
			if(progressFunction!=null) {
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progressFunction);
			}
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onFinished);
			function onFinished(e:Event):void {
				client = MovieClip(loader.content);
				dispatchEvent(new DongleEvent(DongleEvent.MEDIA_BRIDGE));
			}
		}
		public function transmit(functionEnd:String=null,input:String="bridgeInput",output:String="bridgeOutput"):void {
			for(var key:String in host[input]) {
				client[output][key] = host[input][key];
			}
			if(functionEnd != null) {
				client[functionEnd]();
			}
			dispatchEvent(new DongleEvent(DongleEvent.MEDIA_TRANSMIT_END,true));
		}
		public function display():void {
			host.addChild(client);
			client.addEventListener(DongleEvent.MEDIA_UNBRIDGE,close);
		}
		public function close(e:DongleEvent):void {
			host.removeChild(client);
		}
	}
	
}
