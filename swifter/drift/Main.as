package swifter.drift  {
	import flash.display.MovieClip;
	import flash.utils.*;
	import flash.media.Sound;
	public final class Main {
		public static const MIDDLE_X:Number = 200;
		public static const MIDDLE_Y:Number = 200;
		public static const MAXIMUM_ITEMS:Number = 10;
		
		private static const ROOMS_OFFSET:Number = 310;
		
		public static var rooms:RoomContainer;
		public static var roomsList:Array;
		
		public static var inventoryContainer:MovieClip = new inventoryMC();
		inventoryContainer.y = 400;
		
		public static var inventory:Array = new Array();
		
		private static var roomsMoving:Boolean = false;
		private static var prevRoomX:Number;
		private static var prevRoomY:Number;
		private static var currentDepth:Number;
		private static var roomsFriction:Number;
		private static var transition:Number;
		
		public static function warp(origin:Room,destination:Room,direction:String,sfx:Sound=null):void {
			if(!roomsMoving) {
				roomsMoving = true;
				if(currentDepth==0)
					currentDepth=1;
				else if(currentDepth==1)
					currentDepth=0;
				prevRoomX = rooms.getChildByName(origin.name).x;
				prevRoomY = rooms.getChildByName(origin.name).y;
				rooms.addRoom(destination,currentDepth);
				if(sfx!=null)
					sfx.play();
				switch(direction) {
					case "left":
						destination.x = prevRoomX-ROOMS_OFFSET;
						destination.y = prevRoomY;
						break;
					case "right":
						destination.x = prevRoomX+ROOMS_OFFSET;
						destination.y = prevRoomY;
						break;
					case "up":
						destination.x = prevRoomX;
						destination.y = prevRoomY-ROOMS_OFFSET;
						break;
					case "down":
						destination.x = prevRoomX;
						destination.y = prevRoomY+ROOMS_OFFSET;
						break;
				}
				roomsFriction=0;
				clearInterval(transition);
				transition = setInterval(moveRooms,25,origin,destination);
			}
		}
		private static function moveRooms(origin:Room,destination:Room):void {
			if(roomsFriction <= 0.4)
				roomsFriction+=0.05;
			var diffX:Number = Math.round((- Main.rooms.getChildByName(destination.name).x + Main.MIDDLE_X -Main.rooms.x)*roomsFriction);
			var diffY:Number = Math.round((- Main.rooms.getChildByName(destination.name).y + Main.MIDDLE_Y -Main.rooms.y)*roomsFriction);
			rooms.x += diffX;
			rooms.y += diffY;
			if(Math.abs(diffX+diffY)<=1) {
				roomsMoving = false;
				Main.rooms.removeChild(Main.rooms.getChildByName(origin.name));
				Main.rooms.x = - Main.rooms.getChildByName(destination.name).x + Main.MIDDLE_X;
				Main.rooms.y = - Main.rooms.getChildByName(destination.name).y + Main.MIDDLE_Y;
				clearInterval(transition);
			}
		}
		public static function jump(destination:Room,sfx:Sound=null):void {
			if(!roomsMoving) {
				if(sfx!=null)
					sfx.play();
				prevRoomX = Main.rooms.getChildByName(destination.name).x;
				prevRoomY = Main.rooms.getChildByName(destination.name).y;
				Main.rooms.addRoom(destination,currentDepth);
				destination.x = prevRoomX;
				destination.y = prevRoomY;
			}
		}
		public static function reset():void {
			currentDepth = 0;
			roomsMoving = false;
			restoreRoom();
		}
		public static function restoreRoom():void {
			var startingRoom:Room = Main.roomsList[0];
			Main.rooms.addRoom(startingRoom);
			jump(Room(Main.rooms.getChildByName(startingRoom.name)),new btnSnd());
		}
		public static function inventoryFull():void {
			trace("Inventory is full");
		}
	}
	
}
