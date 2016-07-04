$(document).on("pagebeforecreate",function(event){
        document.location="objc://"+"getChartsData"+":/"+"familytatisticscharts";
		 // window.Android.getChartsData("familytatisticscharts");
	 });

	 function showCharts(jsonData){
		charts = function(id,chartsData){
			revenueChart = new FusionCharts({
                type: "doughnut2d",
                renderAt: id,
                width: "100%",
                height: "40%",
                dataFormat: "json",
                dataSource: {
                    chart: {
                    	bgColor:"#ffffff",
                    	legendIconScale:1.5,
                        showLegend:1,
                        "caption": "",
                        "showBorder": "0",
                        "use3DLighting": "0",
                        "enableSmartLabels": "1",
                        smartLineColor:"#c2c2c2c",
                        "startingAngle": "120",
                        "showLabels": "1",
                        "showPercentValues": "1",
                        "enablemultislicing": "0",
                        "showLegend": "0",
                        legendNumColumns:1,
                        drawCustomLegendIcon:1,
                        legendIconBorderThickness:0,
                        slicingdistance: "10",
                        legendItemFontSize:"18",
                        labelFontSize:10,
                        "showTooltip": "0",
                        "decimals": "0",
                        "useDataPlotColorForLabels": "1",
                        "theme": "fint"
                    },
                    data: chartsData
                },
                "events": {
                    "renderComplete": function (eventObj, dataObj) {
						document.location="objc://"+"hideProgressBar"+":/";
                    }
                }
            });
            revenueChart.render();
		};

         FusionCharts.ready(function () {
        	 charts("memberChartContainer",jsonData.labels);
        	 charts("medicineChartContainer",jsonData.charts);
	     });
//////////////////////////////////////
	 }