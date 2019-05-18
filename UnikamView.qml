import QtQuick 2.0
import QtQuick.Controls 2.0
//import Qt.WebSockets 1.0

Item {
    id: r
    anchors.fill: parent
    property string ip: '127.0.0.1'
    property int port: 12345
    property bool byDefault: true
    property string serverName: 'chatserver'
    property var container: xQmlObjects
    Component.onCompleted:{
        var appArgs = Qt.application.arguments
        for(var i=0;i<appArgs.length;i++){
            //console.log('------------------->'+appArgs[i])
            var arg=''+appArgs[i]
            if(arg.indexOf('-ip=')===0){
                var m0=arg.split('=')
                r.ip=m0[1]
                r.byDefault=false
            }
        }
        for(var i=0;i<appArgs.length;i++){
            //console.log('------------------->'+appArgs[i])
            arg=''+appArgs[i]
            if(arg.indexOf('-port=')===0){
                m0=arg.split('=')
                r.port=m0[1]
                r.byDefault=false
            }
        }
        unik.startWSS(r.ip, r.port, r.serverName);
    }    
    Text {
        id: info
        text: r.byDefault?'Default: '+r.ip+':'+r.port:'Seted: '+r.ip+':'+r.port
        font.pixelSize: 10
        color: 'white'
    }
    Connections {
        id:connCW
        //target: cw
        onClientConnected:{
            console.log("A new client connected.")
        }
    }
    Timer{
        running:true
        repeat:true
        interval: 1000
        onTriggered: {
            if(cw){
                connCW.target=cw
                stop()
            }
        }
    }
    Connections {
        target: cs
        onUserListChanged:{
            //listModelUser.updateUserList()
        }
        property int v: 0
        onNewMessage:{            
            var c='import QtQuick 2.0\n'
            c+='Image{\n'
            c+='    id: r;\n'
            c+='    anchors.centerIn:parent\n'
            c+='    source:"data:image/png;base64,"+'+msg+';\n'
            c+='    Component.onCompleted: r.destroy(200)\n'
            c+='}'
            var comp=Qt.createQmlObject(c, r, 'codeWSS')
        }
    }
    /*Column{
        anchors.fill: parent
        Row{
            width: parent.width
            height: parent.height-28
            Rectangle{
                width: parent.width*0.7
                height: parent.height
                border.width: 1
                clip: true
                Rectangle{
                    width: parent.width
                    height: 28
                    color: "black"
                    Text {
                        text: "<b>Messages</b>"
                        font.pixelSize: 24
                        anchors.centerIn: parent
                        color: "white"
                    }
                }
                ListView{id:msgListView;width: parent.width; height: parent.height-28; y:28; spacing: 10; clip: true; model: listModelMsg; delegate: delegateMsg;}
            }
            Rectangle{
                width: parent.width*0.3
                height: parent.height
                border.width: 1
                clip: true
                Rectangle{
                    width: parent.width
                    height: 28
                    color: "black"
                    Text {
                        text: "<b>User List</b>"
                        font.pixelSize: 24
                        anchors.centerIn: parent
                        color: "white"
                    }
                }
                ListView{id:userListView;width: parent.width; height: parent.height-28; y:28; spacing: 10; clip: true; model: listModelUser; delegate: delegateUser;}
            }
        }
    }
    ListModel{
        id: listModelUser
        function createElement(u){
            return {
                user: u
            }
        }
        function updateUserList(){
            clear()
            var ul = cs.userList;
            for(var i=0; i < ul.length; i++){
                append(createElement(ul[i]))
            }
        }
    }
    ListModel{
        id: listModelMsg
        function createElement(m){
            return {
                msg: m
            }
        }
        function addMsg(msg){
            append(createElement(msg))
            msgListView.currentIndex = count-1
        }
    }
    Component{
        id: delegateUser
        Rectangle{
            width: userListView.width*0.9
            height: 24
            border.width: 1
            color: "#cccccc"
            radius: 6
            anchors.horizontalCenter: parent.horizontalCenter
            clip:true
            Text {
                text: "<b>"+user+"</b>"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
        }
    }
    Component{
        id: delegateMsg
        Rectangle{
            width: msgListView.width*0.9
            height: txtMsg.contentHeight
            border.width: 1
            color: "#cccccc"
            radius: 6
            anchors.horizontalCenter: parent.horizontalCenter
            clip:true
            Text {
                id: txtMsg
                width: parent.width-48
                height: contentHeight
                text: "<b>"+msg+"</b>"
                font.pixelSize: 20
                anchors.centerIn: parent
                wrapMode: Text.WordWrap
            }
        }
    }
*/
    function clear(){
        for(var i=0;i<xQmlObjects.children.length;i++){
            xQmlObjects.children[i].destroy(1)
        }
    }
}
