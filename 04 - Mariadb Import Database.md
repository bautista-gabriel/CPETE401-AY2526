
# MariaDB/MySQL Database Import and Export Instructions for Windows

Here are the instructions for exporting and importing a SQL file in Windows using the command line.

### Exporting a Database to a SQL File

To export a database, you can use the `mysqldump` utility. This command will create a `.sql` file containing the database structure and data.

**Command:**
```bash
mysqldump -u [username] -p [database_name] > [filename].sql
```

**Explanation:**

*   `[username]`: Your database username.
*   `[database_name]`: The name of the database you want to export.
*   `[filename].sql`: The name of the file you want to save the export to.

After running this command, you will be prompted to enter your password.

### Importing a SQL File into a Database

To import a `.sql` file into an existing database, you can use the `mysql` command-line client.

**Command:**
```bash
mysql -u [username] -p [database_name] < [filename].sql
```

**Explanation:**

*   `[username]`: Your database username.
*   `[database_name]`: The name of the database you want to import into.
*   `[filename].sql`: The name of the SQL file you want to import.

You will also be prompted for your password after executing this command.
