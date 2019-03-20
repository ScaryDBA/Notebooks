$DBConnectionString = 'Driver={PostgreSQL Unicode(x64)};Server=postgrelearning.postgres.database.azure.com;Database=postgrelearning;port=5432;Uid=Grant@postgrelearning;Pwd=$cthulhu1988;'
$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();
$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "SELECT * FROM mytable;";
$DBCmd.ExecuteReader();
$DBConn.Close();