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
/// <li><b>Mode (Default Value = "2")</b>: Optional integer to determine which mode the query will be run on</li>
/// <li><b>Dialect (Default Value = "CACHE")</b>: Optional string to determine which dialect the query will use</li>
/// </ul></p>
/// <h2>Example</h2>
/// <pre>
/// USER> write ##class(User.SQLtoObject).Build("SELECT AircraftCategory FROM Aviation.Aircraft","SAMPLES")
/// 27@%Library.DynamicArray
/// USER> write ##class(User.SQLtoObject).Build("SELECT AircraftCategory FROM Aviation.Aircraft","SAMPLES").%ToJSON()
/// [{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"},{"AircraftCategory":"Airplane"}... etc.
/// </pre>
/// <p>SQL errors will be written out imediately, and logic errors will be returned in the return object
/// </html>
ClassMethod Build(pQuery, pNamespace As %String = "", pMode As %String = 2, pDialect As %String = "CACHE") As %Status
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
		set qStatus = tStatement.%Prepare(pQuery)	
		if qStatus '= 1 {
			write "%Prepare failed:" do $System.Status.DisplayError(qStatus) quit
		}
		
		// Run the query
		set rSet = tStatement.%Execute()
		
		set tResults = []
		set tColumns = ""
		
		// Metadata handling, gets column name information and counts
		set tMetadata = rSet.%GetMetadata()
    	set tColumnCount = tMetadata.columns.Count()
    	for x=1:1:tColumnCount {
	        set tColumn = tMetadata.columns.GetAt(x)
	        set tColumnName = tColumn.colName
	        set tColumns = tColumns _ $lb(tColumnName)
	    }

		// loop through the result set returned by the query
		while rSet.%Next() {
			set tRow = {}
			// Set key/value pair based on the incremenet of the result set
			for x=1:1:tColumnCount {
				do tRow.%Set($lg(tColumns, x), rSet.%GetData(x) )
			}
			// Push the entire object to a final set of data
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
