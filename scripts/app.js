const FabricService = require('./fabricService')

const fabricService = new FabricService();

function enrollAdmin() { 
    fabricService.enrollAdmin().then((results) => {
        return results;
    });
}

function registerUser() { 
    fabricService.registerUser().then((results) => {
        return results;
    });
}

function SetData(key, value) { 
    fabricService.SetData(key, value).then((results) => {
        return results;
    });
}

function gethistory(key) { 
    fabricService.GetHistory(key).then((results) => {
	    var obj = JSON.parse(results);
	    for(var i=0,l=obj.length;i<l;i++){
		    console.log(obj[i].Timestamp + ' ' + key + ' '  + obj[i].Value);
	    }
    });
}

function GetData(key) { 
    fabricService.GetData(key).then((results) => {
	    console.log(results);
    });
}

var func = process.argv[2];
var key = process.argv[3]; 
var value = process.argv[4]; 

if (func == undefined)
{
	console.log("数据上链: node app setvalue key value");
	console.log("读取当前数据: node app getvalue key");
	console.log("读取历史交易记录: node app GetHistroy key");
	return
}
else
{
	if (func == 'setvalue')
	{
		if (key == undefined || value == undefined)
		{
			console.log("数据上链: node app setvalue key value");
			return
		}

		SetData(key, value);
		console.log("sucess!");
		return
	}
	else if (func == 'getvalue')
	{
		if (key == undefined)
		{
			console.log("读取当前数据: node app getvalue key");
			return
		}

		GetData(key);
	}
	else if (func == 'gethistory')
	{
		if (key == undefined)
		{
			console.log("读取历史交易记录: node app GetHistroy key");
			return
		}

		gethistory(key);
		return
	}
	else
	{
		console.log("数据上链: node app setvalue key value");
		console.log("读取当前数据: node app getvalue key");
		console.log("读取历史交易记录: node app GetHistroy key");

		return
	}
}
