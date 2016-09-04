package swifter.animator.dynamic {
	import flash.display.MovieClip;
	public dynamic class SmartObject extends MovieClip {
		private var clip:MovieClip;
		public var objectName:String;
		public function SmartObject(mc:MovieClip,instanceName:String="SO") {
			clip = mc;
			addChild(clip);
			name = instanceName;
		}

	}
	
}
