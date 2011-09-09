require 'mysql'

begin
	db = Mysql.real_connect("genome-mysql.cse.ucsc.edu", "genome", "", "hg19")
	puts "Server version: " + db.get_server_info
	sql = db.query("SELECT table_name FROM INFORMATION_SCHEMA.TABLES WHERE table_schema='hg19' ORDER BY table_name")
	sql.each do |row|
	puts row[0]
	end
rescue Mysql::Error => e
	puts "Error code: #{e.errno}"
	puts "Error message: #{e.error}"
	puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
ensure
	db.close if db
end
