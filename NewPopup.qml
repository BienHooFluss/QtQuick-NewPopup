import QtQuick 2.0
import QtQuick.Controls 2.15

//Popup {
//    id:             popupBottom
//    modal:          true        //模态， 为 true后弹出窗口会叠加一个独特的背景调光效果
//    focus:          true        //焦点,  当弹出窗口实际接收到焦点时，activeFocus将为真
//    closePolicy:    Popup.CloseOnEscape | Popup.CloseOnPressOutside
//    padding:        0           //很重要
//    property var    raiseItem:     null  //要显示的组件
//    property var    btnItem:       null  //提供位置的组件
//    background: Rectangle {
//        color:  Qt.rgba(0,0,0,0)    //背景为无色
//    }
//    Loader {
//        id:             loaderBottom
//        onLoaded: {
//            var item =  rootWindow.contentItem.mapFromItem(popupBottom.btnItem, 0 ,0)
//            console.log("rootWindow.contentItem.width:",rootWindow.contentItem.width)
//            console.log("rootWindow.contentItem.height:",rootWindow.contentItem.height)
//            console.log("item.x:",item.x)
//            console.log("item.y:",item.y)
//            popupBottom.x = item.x
//            //考虑右边边界问题
//            if(popupBottom.x + loaderBottom.width > rootWindow.width) {
//                popupBottom.x = rootWindow.width - loaderBottom.width
//            }
//            //考虑左边边界问题
//            popupBottom.y = item.y + popupBottom.height
//            console.log("loaderBottom.width:",loaderBottom.width)
//            console.log("loaderBottom.height:",loaderBottom.height)
//            console.log("popupBottom.width:",loaderBottom.width)
//            console.log("popupBottom.height:",popupBottom.height)
//            if(popupBottom.y + loaderBottom.height > rootWindow.height) {
//                popupBottom.y = rootWindow.height - loaderBottom.height
//            }
//            console.log("popupBottom.x:",popupBottom.x)
//            console.log("popupBottom.y:",popupBottom.y)
//        }
//    }
//    onOpened: {
//        loaderBottom.sourceComponent = popupBottom.raiseItem
//    }
//    onClosed: {
//        loaderBottom.sourceComponent = null
//        popupBottom.raiseItem = null
//    }
//}


Popup {
    id:             popupCenter
    modal:          true            //模态， 为 true后弹出窗口会叠加一个独特的背景调光效果
    focus:          true            //焦点,  当弹出窗口实际接收到焦点时，activeFocus将为真
    padding:        0
    closePolicy:    Popup.CloseOnEscape | Popup.CloseOnPressOutside
    property var    raiseItem:          null
    signal hideContent()
    background: Rectangle {
        color:      Qt.rgba(0,0,0,0)   //背景为无色
    }
//    Loader {
//        id: loaderCenter
//        onLoaded: {
//            console.log("loaderCenter.x:",loaderCenter.x)
//            popupCenter.x = rootWindow.centerPointX + rootWindow.centerPointWidth / 2//loaderCenter.x//(rootWindow.width - loaderCenter.width) * 0.5
//            popupCenter.y = (rootWindow.height - loaderCenter.height) * 0.5
//            popupCenter.width = loaderCenter.width
//            popupCenter.height = loaderCenter.height
//        }
//    }

    Rectangle {
        id: rect
        color: "red"
        anchors.fill: parent
    }

    Button {
        id: button
        text: "关闭"
        onClicked: {
            hideAnimation.running = true
            //popupCenter.close()
            //hideContent()
        }
        anchors {
            right: parent.right
            rightMargin: 20
            bottom: parent.bottom
            bottomMargin: 20
        }
    }

    onOpened: {
        //hideAnimation.running = false
        //showAnimation.running = true
        popupCenter.visible = true
        popupCenter.scale = 1
        popupCenter.x = rootWindow.centerPointX + rootWindow.centerPointWidth / 2//loaderCenter.x//(rootWindow.width - loaderCenter.width) * 0.5
        popupCenter.y = rootWindow.popupPosY//(rootWindow.height - loaderCenter.height) * 0.5
        console.log("popupCenter.x:",popupCenter.x)
        console.log("popupCenter.y:",popupCenter.y)
        popupCenter.width = 300//loaderCenter.width
        popupCenter.height = 300//loaderCenter.height
        //loaderCenter.sourceComponent = popupCenter.raiseItem
    }
    onHideContent: {
        //loaderCenter.sourceComponent = null
        popupCenter.raiseItem = null
    }

    onClosed: {
        hideAnimation.running = true
        popupCenter.close()
        //loaderCenter.sourceComponent = null
        //popupCenter.raiseItem = null
    }

    ParallelAnimation {
        id: hideAnimation
        running: false
        PropertyAnimation {
            id: animSmall
            target: popupCenter
            duration: 300//root.duration
            easing.type: Easing.OutBounce//root.easingType
            property: 'scale';
            from: 1;
            to: 0
        }
        PropertyAnimation {
            id: animMoveX
            target: popupCenter//root
            duration: 300//root.duration
            easing.type: Easing.OutBounce//root.easingType
            property: 'x';
            to: -(rootWindow.centerPointX + rootWindow.centerPointWidth / 2)
        }
        PropertyAnimation {
            id: animMoveY
            target: popupCenter//root
            duration: 300//root.duration
            easing.type: Easing.OutBounce//root.easingType
            property: 'y';
            to: -(rootWindow.popupPosY)//rootWindow.centerPointY + rootWindow.centerPointHeight / 2
        }
        PropertyAnimation {
            target: popupCenter//root
            duration: 300//root.duration
            easing.type: Easing.OutBounce//root.easingType
            property: 'visible';
            to: false//(rootWindow.height - loaderCenter.height) * 0.5//rootWindow.centerPointY + rootWindow.centerPointHeight / 2
        }
    }

    ParallelAnimation {
        id: showAnimation
        running: false
        PropertyAnimation {
            target: popupCenter
            duration: 300//root.duration
            easing.type: Easing.OutBounce//root.easingType
            property: 'scale';
            from: 0;
            to: 1
        }
        PropertyAnimation {
            target: popupCenter//root
            duration: 300//root.duration
            easing.type: Easing.OutBounce//root.easingType
            property: 'x';
            to: rootWindow.centerPointX + rootWindow.centerPointWidth / 2
        }
        PropertyAnimation {
            target: popupCenter//root
            duration: 300//root.duration
            easing.type: Easing.OutBounce//root.easingType
            property: 'y';
            to: rootWindow.popupPosY//(rootWindow.height - loaderCenter.height) * 0.5//rootWindow.centerPointY + rootWindow.centerPointHeight / 2
        }
        PropertyAnimation {
            target: popupCenter//root
            duration: 300//root.duration
            easing.type: Easing.OutBounce//root.easingType
            property: 'visible';
            to: true//(rootWindow.height - loaderCenter.height) * 0.5//rootWindow.centerPointY + rootWindow.centerPointHeight / 2
        }
    }
}
