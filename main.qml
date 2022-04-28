import QtQuick 2.5
import QtQuick.Window 2.2
//import QtQml 2.15
import QtQuick.Controls 2.5
import QtQml 2.15

Window {
    id: rootWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    //公有属性
    property var centerPointX: 20
    property var centerPointY: 30
    property var centerPointWidth: 100
    property var centerPointHeight: 60
    property var popupPosY: 100
//    SectorProgressBar {
//        anchors.centerIn: parent
//    }

//    TestPopAndMask {
//        id: testPopAndMask
//        anchors.fill: parent
//    }

//    function showPopupBottom(raiseItem, btnItem) {
//        popupBottom.raiseItem = raiseItem
//        popupBottom.btnItem = btnItem
//        popupBottom.open()
//    }

    function showPopupCenter(raiseItem) {
        //popupCenter.raiseItem = raiseItem
        popupCenter.open()
    }

    NewPopup {
        id: popupCenter
    }

    Component {
        id:     display1
//        signal closePopup()
        Rectangle {
            width:                  lab1.width*1.5
            height:                 lab1.height*5
            radius:                 height*0.2
            color:                  "#FF9D6F"
            border.width:           4
            border.color:           "black"
            Label {
                id:                 lab1
                anchors.centerIn:   parent
                font.bold:          true
                font.pointSize:     20
                text:               "测试界面"
            }

//            Button {
//                anchors {
//                    bottom: parent.bottom
//                    bottomMargin: 30
//                    right: parent.right
//                    rightMargin: 30
//                }
//                onClicked: {
//                    closePopup()
//                }
//            }
        }
    }

    Button {
        id:     btn1
        width: centerPointWidth
        height: centerPointHeight
        text:  "测试1"
        onClicked: {
            rootWindow.showPopupCenter(display1)

        }
        x: centerPointX
        y: centerPointY
    }

//    Component {
//        id:     display2
//        Rectangle {
//            width:                  lab2.width*1.5
//            height:                 lab2.height*5
//            radius:                 height*0.2
//            color:                  "#97CBFF"
//            border.width:           4
//            border.color:           "black"
//            Label {
//                id:                 lab2
//                anchors.centerIn:   parent
//                font.bold:          true
//                font.pointSize:     20
//                text:               "测试界面2(底部)"
//            }
//        }
//    }

//    Button {
//        id:     btn2
//        text:  "测试2"
//        onClicked: {
//            rootWindow.showPopupBottom(display2,btn2)
//        }
//        anchors {
//            left: parent.left
//            leftMargin: 20
//            top: parent.top
//            topMargin: 30
//        }
//    }

//    NewPopup {
//        id: newPopup
//    }
//    Component {
//        id:     display2
//        Rectangle {
//            width:                  lab2.width*1.5
//            height:                 lab2.height*5
//            radius:                 height*0.2
//            color:                  "#97CBFF"
//            border.width:           4
//            border.color:           "black"
//            Label {
//                id:                 lab2
//                anchors.centerIn:   parent
//                font.bold:          true
//                font.pointSize:     20
//                text:               "测试界面2(底部)"
//            }
//        }
//    }
}
