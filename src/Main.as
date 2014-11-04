package 
{
	import flash.display.Sprite;
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.desktop.NativeProcess;
	import flash.filesystem.File;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author SIHO
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
				
			
		}
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, keyCommands);
		}
		private function keyCommands(e:KeyboardEvent):void
		{
			trace("keyCommands", e.keyCode);
			switch (e.keyCode) 
			{
				case 81://Qキー
					serialPrinter("QR");
				break;
				case 84://Tキー
					serialPrinter("Str");
				break;
				case 76://Lキー
					serialPrinter("logo");
				break;
			}		
		}
		
		private function serialPrinter(str:String):void
		{
			var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			var file:File = File.applicationDirectory.resolvePath("SerialPrinter.exe");
			trace("serialPrinter", file.nativePath);
			nativeProcessStartupInfo.executable = file;
			var processArgs:Vector.<String> = new Vector.<String>();
			processArgs.push("COM30");//デバイスとプリンターで確認してください。
			switch (str)
			{
				case "logo": 
					processArgs.push("img");
					var ifile:File = File.applicationDirectory.resolvePath("logo.bmp");
					processArgs.push(ifile.nativePath);
					break;
				case "QR": 
					processArgs.push("QR");
					processArgs.push("http://www.viva-mambo.co.jp/");
					break;
				case "Str": 
					processArgs.push("text");
					processArgs.push("QRコードを読み取って画像をダウンロードしてね");
					break;
			}
			trace("serialPrinter", processArgs);
			nativeProcessStartupInfo.arguments = processArgs;
			var process:NativeProcess = new NativeProcess(); 
			process.start(nativeProcessStartupInfo);
		}
		
	}
	
}