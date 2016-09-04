package swifter.dongle  {
	import flash.net.LocalConnection;
	import flash.display.MovieClip;
	import flash.net.SharedObject;

	public class Dongle extends SharedObject {
		public var saveFile:Object;
		private var connector:LocalConnection;
		
		public function Dongle() {
			saveFile = new Object();
			connector = new LocalConnection();
		}
		
		public function save(file:Object) {
			for(var key in file) {
				saveFile[key] = file[key];
			}
		}
		
		public function hostLink(token:String,method:String) {
			connector.send(token,method,saveFile);
		}
		public function hostCall(domain:String,token:String,method:String) {
			connector.send(domain+":"+token,method,saveFile);
		}
		public function hostGuess(token:String,method:String) {
			connector.send("_"+token,method,saveFile);
		}
		public function clientLink(client:MovieClip,token:String) {
			connector.connect(token);
			connector.client = client;
		}
		public function clientCall(client:MovieClip,token:String,...domains:Array) {
			domains.forEach(allowDomains);
			connector.connect(token);
			connector.client = client;
		}
		public function clientGuess(client:MovieClip,token:String) {
			connector.allowDomain('*');
			connector.connect("_"+token);
			connector.client = client;
		}
		private function allowDomains(domain:String,index:int,list:Array) {
			connector.allowDomain(domain);
		}
	}
	
}
