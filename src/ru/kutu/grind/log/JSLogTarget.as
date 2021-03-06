package ru.kutu.grind.log {
	
	import flash.external.ExternalInterface;
	
	import robotlegs.bender.extensions.enhancedLogging.impl.LogMessageParser;
	import robotlegs.bender.framework.api.ILogTarget;
	import robotlegs.bender.framework.api.LogLevel;
	
	public class JSLogTarget implements ILogTarget {
		
		private const _messageParser:LogMessageParser = new LogMessageParser();
		
		public function log(source:Object, level:uint, timestamp:int, message:String, params:Array=null):void {
			if (ExternalInterface.available) {
				ExternalInterface.call(
					level == LogLevel.DEBUG ? "console.debug" :
					level == LogLevel.INFO ? "console.info" :
					"console.warn"
					,
					[
						timestamp
						, LogLevel.NAME[level]
						, source
						, _messageParser.parseMessage(message, params)
					].join(" ")
				);
			}
		}
		
	}
	
}
