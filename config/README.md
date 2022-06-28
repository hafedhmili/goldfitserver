After making changes:
*  npx tsc: this will translate typescript files into equivalent javascript files found generated in the /build directory. "npm start" actually executes a javascript file from that directory
*   (optional) git status, to see what changed
*   if there are new files (status would tell us that), do "git add ." to add everything under the current directory
*   git commit -a -m "message explaining changes made to code that was just piushed" 
*   git push origin main: this will push the current local branch (main) onto the original remote repository branch (on github)
*   git push heroku main: will do the same thing but to the heroku built-inm repository. This will have been set-up initially with heroku CLI in the same home directory of the project. This command will also build the application for deployment on heroku.

To update the database, there are two ways.
1) Brute force way:
*   Make changes to local postgres database using pgAdmin to change the schema, and add/modify the data
*   Create a backup of the database within pgAdmin in plain text format by asking to save schema and data, and excluding stuff about authorization. This will generate an editable SQL text file.
*   Start the PG SQL CLI on the heroku data base. This can be done by typing the command heroku pg:psql. If you are not authenticated on heroku, it will ask you to.
*   Inside pg:psql, type \ir relative-path-name-sql-file ;
*   This will execute the SQL file. Make sure that the SQL file contains a "DROP SCHEMA goldfit" command, so that it starts afresh
*   Make sure that the file /config/config.env has the appropriate database URI, which includes the URL and the credentials. You can find those by looking at the settings of the database (credentials) within the heroku portal
