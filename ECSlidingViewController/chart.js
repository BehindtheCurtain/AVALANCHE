//fileName: name of XML file
//sensorName: exact name of sesnor within XML doc
//sensorType: type of sensor to be charted

function buildChart(fileName, sensorName, yLabel)
{
	var margin = {
		top: 30,
		right: 10,
		bottom: 30,
		left: 40
	},
		width = 550 - margin.left - margin.right,
		height = 255 - margin.top - margin.bottom;

	var x = d3.time.scale()
		.range([0, width]);

	var y = d3.scale.linear()
		.range([height, 0]);

	var xAxis = d3.svg.axis()
		.scale(x)
		.orient("bottom");

	var yAxis = d3.svg.axis()
		.scale(y)
		.orient("left");

	var line = d3.svg.line()
		.x(function (d)
	{
		return x(d.date);
	})
		.y(function (d)
	{
		return y(d.close);
	});

	var svg = d3.select("body").append("svg")
		.attr("width", width + margin.left + margin.right)
		.attr("height", height + margin.top + margin.bottom)
		.append("g")
		.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

	d3.xml(fileName, function (xml)
	{
		//Total number of sensors in the XMl file
		var sensorCount = d3.select(xml).select("sensors").selectAll("sensor")[0].length;
		//Input sensor index in the XML file
		var sensorIndex = -1;

		//Find the input sensor location in the given XML file
		for(var i = 0; i < sensorCount; i++)
		{
			if(d3.select(xml).selectAll("sensor")[0][i].getAttribute("name") == sensorName)
			{
				sensorIndex = i;
			}
		}


		var dateTest = new Date((d3.select(xml).selectAll("startTime")[0][0].textContent)*1000);

		$('#date').text("Date: " + dateTest.toLocaleString());
		$('#average').text("Average: " + d3.select(xml).selectAll("sensor").select("average")[0][sensorIndex].textContent);
		$('#min').text("Min: " + d3.select(xml).selectAll("sensor").select("min")[0][sensorIndex].textContent);
		$('#max').text("Max: " + d3.select(xml).selectAll("sensor").select("max")[0][sensorIndex].textContent);

		//console.log(d3.select(xml).selectAll("sensor").select("max")[0][sensorIndex].textContent)


		var data = [];
		var len = d3.select(xml).select("sensor").selectAll("snapshot").selectAll("data").length; //Number of snapshots available
		var skip = Math.round(len / 100); //Ensure that only 100 points are graphed

		for (var i = 0; i < len; i = i + skip)
		{
			var obj = {
				close: parseInt(d3.select(xml).selectAll("sensor").selectAll("snapshot").select("data")[sensorIndex][i].textContent),
				date: parseInt(d3.select(xml).selectAll("sensor").selectAll("snapshot").select("time")[sensorIndex][i].textContent)
			};
			data.push(obj);
		}

		data.forEach(function (d)
		{
			d.date = d.date;
			d.close = +d.close;
		});

		x.domain(d3.extent(data, function (d)
		{
			return d.date;
		}));
		y.domain(d3.extent(data, function (d)
		{
			return d.close;
		}));

		svg.append("g")
			.attr("class", "x axis")
			.attr("transform", "translate(0," + height + ")")
			.call(xAxis);

		svg.append("g")
			.attr("class", "y axis")
			.call(yAxis)
			.append("text")
			.attr("transform", "rotate(-90)")
			.attr("y", 6)
			.attr("dy", ".71em")
			.style("text-anchor", "end")
			.text(yLabel);

		svg.append("path")
			.datum(data)
			.attr("class", "line")
			.attr("d", line);
	});
}

function popAlertBox()
{
	alert("I am an alert box!");
}