package {
	import flash.data.SQLConnection;
	import flash.filesystem.File;
	import flash.data.SQLMode; //if you use SQLMode: CREATE | UPDATE | READ
	import flash.data.SQLStatement;
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	
	/**
	 * ...
	 * @author Drew Calupe
	 */
	public class Database {
		
		private static var dbFile:File = File.applicationDirectory.resolvePath("egg_database.db")
		private static var sqlConn:SQLConnection = new SQLConnection();
		private static var sqlStatement:SQLStatement = new SQLStatement();
		private static var result:Array;
		
		public function Database () {
			sqlConn.open(dbFile);
			sqlStatement.sqlConnection = sqlConn;
		}
		
		public static function getMemoryEggGameData():Array {
			sqlStatement.clearParameters()
			sqlStatement.text = "SELECT * FROM memory_egg_game";
			sqlStatement.execute();
			result = sqlStatement.getResult().data;
			return result;
		}
		
		public function getMemoryEggCurrentLevel() {
			
		}
		
		public function getCardPairs() {
			sqlStatement.clearParameters()
			sqlStatement.text = "SELECT card_pairs FROM memory_egg_game";
			sqlStatement.execute();
			result = sqlStatement.getResult().data;
			trace(result[0].card_pairs);
			return result[0].card_pairs;
		}
	}
}