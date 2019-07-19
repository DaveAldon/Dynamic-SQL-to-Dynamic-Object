# Dynamic SQL to Dynamic Object

[![Gitter](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)](https://openexchange.intersystems.com/package/Dynamic-SQL-to-Dynamic-Object)

## Overview

This is an ObjectScript function to convert any sql query into a dynamic object. This returned object will have a key/value pair based on the fieldname and value from the query's result set. The function also has helpful optional parameters to let you switch namespaces on a per-query basis, and change the mode and dialect.

## Features

This function aims to be a one-stop shop for your sql needs, and is especially useful if you need the output eventually converted into json, as shown in the examples section. There are four parameters to the Build function that should be understood before using this code:

* **Query (Required String)**: The query string that will be run
* **Namespace (Optional String)**: Default Value = "" - Runs the query on the defined namespace
* **Mode (Optional String)**: Default Value = "0" - Determines which mode the query will be run on
* **Dialect (Optional String)**: Default Value = "IRIS" - Determines which dialect the query will use

### Mode

Mode values are as follows:
* **0**: Logical
* **1**: ODBC
* **2**: Display

### Dialect

For more information on these different dialect options, see [this article](https://irisdocs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GSQL_dynsql#GSQL_dynsql_dialect).
* **Sybase**
* **MSSQL**
* **MSSQLSERVER**
* **IRIS**
* **CACHE** (If using older versions)

## Example Usage
```sh
USER> write ##class(SQLtoObject.SQLtoObject).Build("SELECT AircraftCategory FROM Aviation.Aircraft","SAMPLES")
27@%Library.DynamicArray

USER> write ##class(SQLtoObject.SQLtoObject).Build("SELECT AircraftCategory FROM Aviation.Aircraft","SAMPLES").%ToJSON()
[{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"}... etc.
```

SQL errors will be written out immediately, and logic errors will be returned in the return object

## Version history
2019-07-18 - v1.0 - Initial commit of function with features outlined in description
