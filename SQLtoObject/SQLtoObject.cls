Class SQLtoObject.SQLtoObject Extends %Persistent
{

/// <html>
/// <head><title>SQLtoObject.SQLtoObject</title></head>
/// <h1>Dynamic SQL to Dynamic Object</h1>
/// <h2>Overview</h2>
/// <p>This function takes a sql query and returns a dynamic object with a key value pair based on the fieldname and value of the result set.</p>
/// <p>There are four parameters for this function:</p>
/// <p><ul>
/// <li><b>Query</b>: The query string that will be run</li>
/// <li><b>Namespace (Default Value = "")</b>: Optional string that will run the query on a different namespace if defined</li>
/// <li><b>Mode (Default Value = "0")</b>: Optional integer to determine which mode the query will be run on</li>
/// <li><b>Dialect (Default Value = "IRIS")</b>: Optional string to determine which dialect the query will use</li>
/// </ul></p>
/// <h2>Example</h2>
/// <pre>
/// USER> write ##class(SQLtoObject.SQLtoObject).Build("SELECT AircraftCategory FROM Aviation.Aircraft","SAMPLES")
/// 27@%Library.DynamicArray
/// USER> write ##class(SQLtoObject.SQLtoObject).Build("SELECT AircraftCategory FROM Aviation.Aircraft","SAMPLES").%ToJSON()
/// [{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"}... etc.
/// </pre>
/// <p>SQL errors will be written out immediately, and logic errors will be returned in the return object
/// </html>
ClassMethod Build(pQuery, pNamespace As %String = "", pMode As %String = 0, pDialect As %String = "IRIS") As %Status
{
	try {
		// Keep track of the original namespace
		set oldNamespace = $namespace
		if pNamespace '= "" set $namespace = pNamespace
		
		// Instantiate the dynamic sql object with the given display mode
		set tStatement = ##class(%SQL.Statement).%New(pMode)
		// Set the dialect of the statement
		set tStatus = tStatement.%DialectSet(pDialect)
		// Set the size of our array that will hold the statements
		set query = 1
		set query(1) = pQuery
		set qStatus = tStatement.%Prepare(pQuery)
		if qStatus '= 1 {
			write "%Prepare failed:" do $System.Status.DisplayError(qStatus) quit
		}
		// Run the query
		set rSet = tStatement.%Execute()
		// Init for parent object
		set tResults = []
		while rSet.%Next() {
			// Init child object for holding the values
			set tRow = {}
			set tMetadata = rSet.%GetMetadata()
			set tColumnCount = tMetadata.columns.Count()
			for x=1:1:tColumnCount {
				// Get column at the current increment
				set tColumn = tMetadata.columns.GetAt(x)
				// Get column name at current increment
				set tColumnName = tColumn.colName
				// Set the property of our object dynamically based on the name and value of the current increment
				set $PROPERTY(tRow,tColumnName) = $PROPERTY(rSet,tColumnName)
			}
			// Push the entire object to the parent
			do tResults.%Push(tRow)
     	}

     	// Revert namespace if changed
     	if $namespace '= oldNamespace set $namespace = oldNamespace

		return tResults
	}
	catch (e) {
		return e.Name
	}
	return $$$OK
}
}
