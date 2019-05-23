<?php

/**
 * phi@smoch.ch
 * 2019-05-19
 */

require_once  __DIR__ . '/../credentials/credentials.php';

class ConnectionSingleton {
	private static $connectionSingleton;
	private        $pdo_conn_obj;

	private function  __construct() {
		global $_CREDENTIALS_HOST_;
		global $_CREDENTIALS_USER_;
		global $_CREDENTIALS_DB_  ;
		global $_CREDENTIALS_PASS_;

        $PDOcharset = 'utf8mb4';
        
        //DSN = Data Source Name (https://en.wikipedia.org/wiki/Data_source_name)
        $dsn = "mysql:host=$_CREDENTIALS_HOST_;dbname=$_CREDENTIALS_DB_;charset=$PDOcharset";
        $opt = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => true,
        ];
        $this->pdo_conn_obj = new PDO($dsn, $_CREDENTIALS_USER_, $_CREDENTIALS_PASS_, $opt);
	}


	private static function getInstance() {
		if(! isset(ConnectionSingleton::$connectionSingleton )) {
			ConnectionSingleton::$connectionSingleton = new ConnectionSingleton();
		}
		return ConnectionSingleton::$connectionSingleton;
	}

	/**
	 * Call
	 * $pdo = ConnectionSingleton::getThePDO();
	 * to get the actual connection object.
	 */
	public static function getThePDO() {
		// instantiate singleton:
		$st = ConnectionSingleton::getInstance(); 
		return $st->pdo_conn_obj;
	}

} // end class "connectionSingleton

?>
