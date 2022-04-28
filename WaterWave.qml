import QtQuick 2.0

Item {

    height:300
    width: 300
    //range信息
    property int rangeValue: 0; //外面调用设置此致即可


    property bool startPainter:true //启动定时器刷新，默认是16ms，也就是60fps
    //画布
    property int mW: height>width?height/2:width/2 // 250;
    property int mH:height>width?height/2:width/2  //250;
    property int lineWidth: 2;

    //圆
    property double r: mH / 2; //圆心
    property double cR: r - 16 * lineWidth; //圆半径

    //圆外圈的颜色
    property color  outerRingLineColor:'#36d1e8'

    //波浪颜色
    property color waveColor: '#1c86d1'

    //显示进度的字体颜色
    property string textColor: "rgba(14, 80, 14, 0.8)"
    //Sin曲线
    property int sX: 0;
    property int sY: mH / 2;
    property int axisLength: mW;        //轴长
    property double waveWidth: 0.015;   //波浪宽度,数越小越宽
    property double waveHeight: 6;      //波浪高度,数越大越高
    property double speed: 0.09;        //波浪速度，数越大速度越快
    property double xOffset: 0;         //波浪x偏移量


    Canvas{
        id: canvas
        height: mH
        width: mW
        anchors.centerIn: parent
        property int nowRange: 0; //不要设置该值
        //antialiasing: true
        onPaint: {
            var ctx = getContext("2d");

            ctx.clearRect(0, 0, mW, mH);

            //显示外圈
            ctx.beginPath();
            ctx.strokeStyle = outerRingLineColor;
            ctx.arc(r, r, cR+5, 0, 2*Math.PI);
            ctx.stroke();
            ctx.beginPath();
            ctx.arc(r, r, cR, 0, 2*Math.PI);
            ctx.clip();

            //显示sin曲线
            ctx.save();
            var points=[];
            ctx.beginPath();
            for(var x = sX; x < sX + axisLength; x += 20 / axisLength){
                var y = -Math.sin((sX + x) * waveWidth + xOffset);
                var dY = mH * (1 - nowRange / 100 );
                points.push([x, dY + y * waveHeight]);
                ctx.lineTo(x, dY + y * waveHeight);
            }

            //显示波浪
            ctx.lineTo(axisLength, mH);
            ctx.lineTo(sX, mH);
            ctx.lineTo(points[0][0],points[0][1]);
            ctx.fillStyle = waveColor;
            ctx.fill();
            ctx.restore();

            //显示百分数
            ctx.save();
            var size = 0.4*cR;
            ctx.font = size + 'px Arial';
            ctx.textAlign = 'center';
            ctx.fillStyle = textColor
            ctx.fillText(~~nowRange + '%', r, r + size / 2);
            ctx.restore();


            //增加Rang值
            if(canvas.nowRange <= rangeValue){
                canvas.nowRange  += 1;
            }
            if(canvas.nowRange > rangeValue){
                canvas.nowRange -= 1;
            }

            xOffset += speed;
        }

        Timer{
            id: timer
            running: startPainter
            repeat: true
            interval: 16
            onTriggered:{
                parent.requestPaint();
            }
        }
    }
}


