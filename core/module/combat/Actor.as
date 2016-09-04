package swifter.core.module.combat {
	import flash.display.MovieClip;
	public class Actor extends MovieClip {
		public var actName:String;
		public var pc:Number;
		public var type1:String;
		public var type2:String;
		public var defType:String;
		public var hybrid:Boolean;
		public var pesp:Number;
		public var atk:Number;
		public var def:Number;
		public var sat:Number;
		public var sdf:Number;
		public var spd:Number;
		public var luk:Number;
		public function Actor(name:String,heartPoints:Number,specPoints:Number,attack:Number,defense:Number,specAttack:Number,specDefense:Number,speed:Number,lucky:Number,typePrim:String,typeSec:String=null,hybridation:Boolean=false) {
			actName = name;
			pc = heartPoints;
			pesp = specPoints;
			atk = attack;
			def = defense;
			sat = specAttack;
			sdf = specDefense;
			spd = speed;
			luk = lucky;
			type1 = typePrim;
			type2 = typeSec;
			hybrid = hybridation;
			if(hybrid && type2!=null) {
				defType = type2;
			} else {
				defType = type1;
			}
		}
		public function readOut():void {
			trace(actName + " is a " + type1 + "/" + type2 + "(hybrid = " + hybrid.toString() + ") foe.");
			trace(actName + " will defend with " + defType);
			trace("ATTACK: " + atk + ", DEFENSE: " + def);
			trace("SPECIAL ATTACK: " + sat + ", SPECIAL DEFENSE: " + sdf);
			trace("SPEED: " + sat + ", LUCKY INDEX: " + luk);
		}

	}
	
}
