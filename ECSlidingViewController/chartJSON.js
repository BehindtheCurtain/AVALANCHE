//fileName: name of json file
//sensorName: exact name of sesnor within json doc
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

	d3.json(fileName, function (json)
	{
		//Number of sensors in the XML file
		var sensorCount = json.run.sensors.sensor.length;
		var sensorIndex = -1;

		//Find the input sensor location in the given json file
		for(var i = 0; i < sensorCount; i++)
		{
			if(json.run.sensors.sensor[i].name == sensorName)
			{
				sensorIndex = i;
			}
		}
		console.log(sensorIndex);

	 	//Update text labels with json data
	 	var dateTest = new Date((json.run.startTime)*1000);
		$('#date').text("Date: " + dateTest.toLocaleString());
		$('#average').text("Average: " + json.run.sensors.sensor[sensorIndex].average);
		$('#min').text("Min: " + json.run.sensors.sensor[sensorIndex].min);
		$('#max').text("Max: " + json.run.sensors.sensor[sensorIndex].max);


		//Total number of snapshots for the selected sensor in the json file
		var len = json.run.sensors.sensor[sensorIndex].snapshots.snapshot.length;

		var data = [];

		for (var i = 0; i < len; i = i+1)
		{
			var obj = {
				close: json.run.sensors.sensor[sensorIndex].snapshots.snapshot[i].data,
				date: json.run.sensors.sensor[sensorIndex].snapshots.snapshot[i].time
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