option = {
    xAxis: {
        type: 'category',
        data: [0, 1, 2, 3, 4, 5, 6, 7, 8,9, 10, 11, 12, 13, 14]
    },
    yAxis: {
        type: 'value',
        show: false
    },
    series: [
        {
            name: 'R',
            type: 'line',
            step: 'start',
            data: [15, 15, 15, 15, 15, 15, 15, 15, 15,15, 15, 15, 20, 20, 20, 15],
            markLine: {
                    data: [[
                        {
                            name : "2 * Delta t",
                            xAxis : 11,
                            yAxis : 3
                        },{
                            name :"2 * Delta t",
                            xAxis: 13,
                            yAxis : 3
                        }
                    ]]
                    },
        },
        {
            name: 'S',
            type: 'line',
            step: 'start',
            data: [7.5, 7.5, 12.5, 12.5, 12.5, 7.5, 7.5, 7.5, 7.5, 7.5, 7.5, 7.5, 7.5, 7.5, 7.5, 7.5],
            markLine: {
                    data: [[
                        {
                            name : "2 * Delta t",
                            xAxis : 1,
                            yAxis : 3
                        },{
                            name :"2 * Delta t",
                            xAxis: 3,
                            yAxis : 3
                        }
                    ]]
                    },
        },
        {
            name: 'Q',
            type: 'line',
            step: 'start',
            data: [0, 0, 0, 0, 5, 5, 5,5,5, 5,5,5, 5, 5, 0, 0],
        }
    ]
};
alert(JSON.stringify(option))
