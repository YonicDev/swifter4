package swifter.core.texts  {
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import flash.events.Event;
	import flash.media.Sound;
	import swifter.core.events.ChatEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	import flash.text.Font;
	import flash.display.MovieClip;

	public class ChatOrganizatorContainer extends ChatOrganizator {
		private var icon:Sprite = new Sprite();
		public var voice:Sound;
		public var openSFX:Sound;
		public var skipSFX:Sound;
		public var closeSFX:Sound;
		
		private var i:int = 0;
		
		private var sayFunction:Function;
		private var switchIFunction:Function;
		private var hideFunction:Function;
		private var waitFunction:Function;
		
		public function ChatOrganizatorContainer() {
			addEventListener(Event.ADDED_TO_STAGE,init);
			voice = null;
			openSFX = null;
			skipSFX = null;
			closeSFX = null;
		}
		private function init(e:Event):void {
			sayFunction = null;
			switchIFunction = null;
			hideFunction = null;
			waitFunction = null;
		}
		public function setSFX(open:Sound=null,voice:Sound=null,skip:Sound=null,close:Sound=null):void {
			this.voice = voice;
			skipSFX = skip;
			openSFX = open;
			closeSFX = close;
		}
		private function appear(speed:Number,textBox:TextField) {
			TweenLite.fromTo(this.getChildAt(0),speed,{alpha:0},{alpha:0.8,onComplete:remark});
			TweenLite.fromTo(textBox,speed,{alpha:0},{alpha:1});
			if(this.icon!=null) {
				TweenLite.fromTo(this.icon,speed,{alpha:0},{alpha:1});
			}
			if(openSFX != null) {
				openSFX.play();
			}
			function remark():void {
				dispatchEvent(new ChatEvent(ChatEvent.APPEAR));
			}
		}
		public function getPosition():int {
			return i;
		}
		public function displayDialogue(textBox:TextField,dialogue:Array,icons:Array,pauseEvent:String,iconScale:Number=1.8,voiceSpeed:Number=25,fadeSpeed:Number=0.5,showHTML:Boolean=false) {
			textBox.text = "";
			sayFunction = sayDialogue(textBox,dialogue,icons,pauseEvent,voiceSpeed,fadeSpeed,showHTML);
			switchIFunction = switchIcons(icons,iconScale);
			hideFunction = toggleHide(fadeSpeed,textBox);
			addEventListener(ChatEvent.APPEAR,sayFunction);
			addEventListener(ChatEvent.FINISH_ARRAY,hideFunction);
			addEventListener(ChatEvent.SWITCH,switchIFunction);
			i=0;
			if(icons[0]!=null) {
				switchIcon(icons[0],iconScale);
			}
			appear(fadeSpeed,textBox);
		}
		
		private function sayDialogue(textBox:TextField,dialogue:Array,icons:Array,pauseEvent:String,voiceSpeed:Number,fadeSpeed:Number,showHTML:Boolean):Function {
			return function(e:Event) {
				removeEventListener(ChatEvent.APPEAR,sayFunction);
				speakArray(textBox,dialogue,pauseEvent,voice,skipSFX,voiceSpeed,showHTML);
			}
		}
		
		public function displayAuto(textBox:TextField,text:String,timer:Timer,icon:Sprite=null,iconScale:Number=1.8,voiceSpeed:Number=25,fadeSpeed:Number=0.45,showHTML:Boolean=false) {
			textBox.text = "";
			sayFunction = sayAuto(textBox,text,icon,voiceSpeed,showHTML);
			waitFunction = waitAuto(timer,fadeSpeed);
			hideFunction = autoHide(timer,fadeSpeed,textBox);
			addEventListener(ChatEvent.APPEAR,sayFunction);
			addEventListener(ChatEvent.FINISH,waitFunction);
			if(icon!=null) {
				switchIcon(icon,iconScale);
			}
			appear(fadeSpeed,textBox);
		}
		
		private function sayAuto(textBox:TextField,text:String,icon:Sprite,voiceSpeed:Number,showHTML:Boolean):Function {
			return function(e:ChatEvent):void {
				removeEventListener(ChatEvent.APPEAR,sayFunction);
				speak(textBox,text,voice,voiceSpeed);
			}
		}
		
		private function waitAuto(timer:Timer,fadeSpeed:Number):Function {
			return function(e:ChatEvent):void {
				removeEventListener(ChatEvent.FINISH,waitFunction);
				timer.start();
				timer.addEventListener(TimerEvent.TIMER_COMPLETE,hideFunction);
			}
		}
		
		private function switchIcons(icons:Array,iconScale:Number):Function {
			return function(e:Event) {
				i++;
				if(i+1<=icons.length) {
					if(icons[i]!=null) {
						switchIcon(icons[i],iconScale);
					}
					
				}
			}
		}
		private function toggleHide(fadeSpeed:Number,textBox:TextField):Function {
			return function(e:Event) {
				disappear(fadeSpeed,textBox);
				removeEventListener(ChatEvent.SWITCH,switchIFunction);
				removeEventListener(ChatEvent.FINISH_ARRAY,hideFunction);
			}
		}
		private function autoHide(timer:Timer,fadeSpeed:Number,textBox:TextField):Function {
			return function(e:Event) {
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE,hideFunction);
				removeEventListener(ChatEvent.FINISH,hideFunction);
				disappear(fadeSpeed,textBox);
			}
		}
		private function switchIcon(icon:Sprite,iconScale:Number) {
			if(this.getChildByName(this.icon.name)!=null) {
				this.removeChild(this.icon);
			}
			this.icon = icon;
			this.icon.alpha = 1;
			this.icon.x = 23.70;
			this.icon.y = 11;
			this.icon.scaleX = this.icon.scaleY = iconScale;
			this.addChild(this.icon);
		}
		private function disappear(speed:Number,textBox:TextField) {
			TweenLite.fromTo(this.getChildAt(0),speed,{alpha:0.8},{alpha:0,onComplete:remark});
			TweenLite.fromTo(textBox,speed,{alpha:1},{alpha:0});
			if(this.icon!=null) {
				TweenLite.fromTo(this.icon,speed,{alpha:1},{alpha:0});
			}
			if(closeSFX !=null) {
				closeSFX.play();
			}
			function remark():void {
				dispatchEvent(new ChatEvent(ChatEvent.DISAPPEAR));
			}
		}
	}
	
}
