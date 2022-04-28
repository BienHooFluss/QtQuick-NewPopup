import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4

// draws two arcs (portion of a circle)
// fills the circle with a lighter secondary color
// when pressed

Rectangle{
    id:id_progress
    height: 300
    width: 300


    //当前进度值，
    property alias value: canvas.rangeValue;

    property color backgroundColor: "#5B5B5B"   //背景颜色
    property color foregroundColor:"#394450"   //前景颜色

    //线宽
    property int lineWidth: 10 //10

    //消息状态
    property alias messageText: id_TextMessaageprogress.text

    //最大值范围，默认是100
    property alias maxRangeValue: canvas.maximumValue


    property var canvasW:id_progress.width
    property var canvasH:id_progress.height

    //字体颜色
    property color textColor: "#DC5712" //"#00BFFF"

    color: "#00000000"
    Canvas {
        id: canvas
        width: canvasW
        height: canvasH
        anchors.centerIn: parent
        antialiasing: true

        property int rangeValue: 0;
        property color primaryColor: foregroundColor//  "orange"
        property color secondaryColor: backgroundColor  //"lightblue"

        property real centerWidth: width/2
        property real centerHeight: height/2
        //property real radius: Math.min(canvas.width, canvas.height) / 2
        property real  radius: Math.min(canvas.width - lineWidth, canvas.height -lineWidth) / 2

        property real minimumValue: 0
        property real maximumValue: 100

        property real currentValue: 0  //当前值
        // this is the angle that splits the circle in two arcs
        // first arc is drawn from 0 radians to angle radians
        // second arc is angle radians to 2*PI radians
        property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI

        // we want both circle to start / end at 12 o'clock
        // without this offset we would start / end at 9 o'clock
        property real angleOffset: -Math.PI / 2

        signal clicked()

        onPrimaryColorChanged: requestPaint()
        onSecondaryColorChanged: requestPaint()
        onMinimumValueChanged: requestPaint()
        onMaximumValueChanged: requestPaint()
        onCurrentValueChanged: requestPaint()

        // 把角度转换为弧度
        function angleToRadian( angle ) {
            return Math.PI / 180 * angle;
        }

        onPaint: {
            var ctx = getContext("2d");
            ctx.save();


            //先画一个静态的内部圆(满圆)
            ctx.beginPath();
            ctx.moveTo(canvas.centerWidth,canvas.centerHeight);
            ctx.lineWidth = 1;
            ctx.strokeStyle = primaryColor;
            ctx.arc(canvas.centerWidth,
                    canvas.centerHeight,
                    canvas.radius , //canvas.radius
                    angleOffset+ canvas.angle,
                    angleOffset + 2*Math.PI);

            ctx.fillStyle = primaryColor;
            ctx.fill();
            ctx.stroke();
            ctx.closePath();
            ctx.restore();

            //开始画一个走动的扇形圆
            ctx.beginPath();
            ctx.lineWidth = 1;
            ctx.strokeStyle = secondaryColor;
            ctx.moveTo(canvas.centerWidth,canvas.centerHeight);

            ctx.arc(canvas.centerWidth,canvas.centerHeight,radius,angleOffset,angleOffset+angle);
            ctx.closePath();
            ctx.fillStyle = secondaryColor;
            ctx.fill();
            ctx.stroke();
            ctx.restore();
            if(currentValue <= rangeValue ){
                currentValue  += 1;
            }
            if(currentValue > rangeValue){
                currentValue -= 1;
            }
        }


        Text {
            id: txt_progress
            anchors.centerIn: parent

            font.pixelSize: 18//FQmlSingleton.font_SuperBig
            text:  canvas.currentValue.toString()+"%"; // canvas.text
            color: textColor
        }
        Text {
            id: id_TextMessaageprogress
            anchors.top: txt_progress.bottom
            anchors.topMargin:10 //FQmlSingleton.spacingMiddle
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 14// FQmlSingleton.font_Middle

            color: textColor
        }

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            onClicked: canvas.clicked()
            onPressedChanged: canvas.requestPaint()
        }


        Timer{
            id: timer
            interval: 16;
            running: true;
            repeat: true;
            onTriggered: {

                parent.requestPaint();
            }

        }
    }

}

