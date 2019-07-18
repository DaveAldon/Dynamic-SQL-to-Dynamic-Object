# Dynamic-SQL-to-Dynamic-Object


/// <html>
/// <head><title>SQLtoObject.SQLtoObject</title></head>
/// <h1>Dynamic SQL to Dynamic Object</h1>
/// <h2>Overview</h2>
/// <p>This function takes a sql query and returns a dynamic object with a key value pair based on the fieldname and value of the result set.</p>
/// <p>There are four parameters for this function:</p>
/// <p><ul>
/// <li><b>Query</b>: The query string that will be run</li>
/// <li><b>Namespace (Default Value = "")</b>: Optional string that will run the query on a different namespace if defined</li>
/// <li><b>Mode (Default Value = "2")</b>: Optional integer to determine which mode the query will be run on</li>
/// <li><b>Dialect (Default Value = "CACHE")</b>: Optional string to determine which dialect the query will use</li>
/// </ul></p>
/// <h2>Example</h2>
/// <pre>
/// USER> write ##class(SQLtoObject.SQLtoObject).Build("SELECT AircraftCategory FROM Aviation.Aircraft","SAMPLES")
/// 27@%Library.DynamicArray
/// USER> write ##class(SQLtoObject.SQLtoObject).Build("SELECT AircraftCategory FROM Aviation.Aircraft","SAMPLES").%ToJSON()
/// [{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"}... etc.
/// </pre>
SQL errors will be written out immediately, and logic errors will be returned in the return object

# Dynamic SQL to Dynamic Object (DSQL-DO)

[![Gitter](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)](https://community.intersystems.com)

### Overview

This is an ObjectScript function to convert any sql query into a dynamic object. This returned object will have a key/value pair based on the fieldname and value from the query's result set. The function also has helpful optional parameters to let you switch namespaces on a per-query basis, and change the mode and dialect.

### Features

This function aims to be a one-stop shop for your sql needs, and is especially useful if you need the output eventually converted into json, as shown in the examples section. There are four parameters to the Build function that should be understood before using this code:

* **Query (Required String)**: The query string that will be run
* **Namespace (Optional String)**: Default Value = "" - Runs the query on the defined namespace
* **Mode (Optional String)**: Default Value = "2" - Determines which mode the query will be run on
* **Dialect (Optional String)**: Default Value = "CACHE" - Determines which dialect the query will use

## Mode

Mode values are as follows:
* **1**:
* **2**:
* **3**:

## Dialect



### Example
```sh
USER> write ##class(SQLtoObject.SQLtoObject).Build("SELECT AircraftCategory FROM Aviation.Aircraft","SAMPLES")
27@%Library.DynamicArray
USER> write ##class(SQLtoObject.SQLtoObject).Build("SELECT AircraftCategory FROM Aviation.Aircraft","SAMPLES").%ToJSON()
[{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"}... etc.
```

SQL errors will be written out immediately, and logic errors will be returned in the return object

### Version history
2019-07-18 - v1.0 - Initial commit of function with features outlined in description
