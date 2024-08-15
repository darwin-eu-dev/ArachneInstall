print("example log statement")

# env <- Sys.getenv()
# envFmt <- paste0(names(env), ": ", unname(env))
# writeLines(envFmt, "environment_vars.txt")

library(DatabaseConnector)
connectionDetails <- createConnectionDetails(dbms = Sys.getenv("DBMS_TYPE"),
                                             connectionString = Sys.getenv("CONNECTION_STRING"),
                                             user = Sys.getenv("DBMS_USERNAME"),
                                             password = Sys.getenv("DBMS_PASSWORD"),
                                             pathToDriver = Sys.getenv("DATABASECONNECTOR_JAR_FOLDER")) # How is this set?

write_schema <- Sys.getenv("RESULT_SCHEMA")
cdm_schema <- Sys.getenv("DBMS_SCHEMA")

con <- connect(connectionDetails)
tables <- getTableNames(con, cdm_schema)

sql <- SqlRender::render("select count(*) as n_persons from @cdm_schema.person", cdm_schema = cdm_schema)
sql <- SqlRender::translate(sql, targetDialect = Sys.getenv("DBMS_TYPE"))

result <- querySql(con, sql)

write.csv(result, "person_count.csv")
writeLines(rownames(installed.packages()), "installed_packages.txt")

disconnect(con)

