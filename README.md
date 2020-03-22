# Dynamic SQL to Dynamic Object

[![Gitter](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)](https://openexchange.intersystems.com/package/Dynamic-SQL-to-Dynamic-Object)

## Overview

This is an ObjectScript function to convert any sql query into a dynamic object. This returned object will have a key/value pair based on the fieldname and value from the query's result set. The function also has helpful optional parameters to let you switch namespaces on a per-query basis, and change the mode and dialect.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 

Open terminal and clone/git pull the repo into any local directory

```
$ git clone git@github.com:DaveAldon/Dynamic-SQL-to-Dynamic-Object.git
```

Open the terminal in this directory and run:

```
$ docker-compose build
```

3. Run the IRIS container with your project:

```
$ docker-compose up -d
```

## How to Run the Application

Open InterSystems IRIS terminal:

```
$ docker-compose exec iris iris session iris
USER>zn "IRISAPP"
IRISAPP>write ##class(SQLtoObject.SQLtoObject).Build("SELECT AircraftCategory FROM Aviation.Aircraft","SAMPLES").%ToJSON()
[{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"}... etc.
```

## How to start coding
This repository is ready to code in VSCode with ObjectScript plugin.
Install [VSCode](https://code.visualstudio.com/), [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugins and open the folder in VSCode.

Right-click on **docker-compose.yml** file and click Compose Restart

Once docker will finish starting procedure and show:

```
Creating objectscript-contest-template_iris_1 ... done
```

Click on the ObjectScript status bar and select Refresh connection in the menu.
Wait for VSCode to make connection and show something like "localhost:32778[IRISAPP] - Connected"

You can start coding after that. Open **ObjectScript.cls** in VSCode, make changes and save - the class will be compiled by IRIS on 'Save'.

## Features

This function aims to be a one-stop shop for your sql needs, and is especially useful if you need the output eventually converted into json, as shown in previously, and later in the examples section. There are four parameters to the Build function that should be understood before using this code:

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
IRISAPP> write ##class(SQLtoObject.SQLtoObject).Build("SELECT AircraftCategory FROM Aviation.Aircraft","SAMPLES")
27@%Library.DynamicArray

IRISAPP> write ##class(SQLtoObject.SQLtoObject).Build("SELECT AircraftCategory FROM Aviation.Aircraft","SAMPLES").%ToJSON()
[{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"}... etc.
```

SQL errors will be written out immediately, and logic errors will be returned in the return object

## Version history
2019-07-18 - v1.0 - Initial commit of function with features outlined in description

2020-03-22 - v1.1 - Compatibility with the InterSystems Online Programming Contest 2020
