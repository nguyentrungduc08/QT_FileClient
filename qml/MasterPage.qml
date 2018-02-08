import VPlayApps 1.0
import QtQuick 2.2
import QtQuick.Dialogs 1.0
import file 1.0
import managerConnecion 1.0

ListPage {
    id: masterPage
    title: "File Client"
    property  var filepatch: "NULL"

    UploadFile {
        id: uploadfile
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            filepatch = fileDialog.fileUrl;
            fileDialog.close()
            masterPage.model.push({ text: filepatch })
            masterPage.modelChanged()
        }
        onRejected: {
            console.log("Canceled")
            fileDialog.close()
        }
        //Component.onCompleted: visible = true
    }

    AppButton {
        icon: IconType.plus
        anchors.right: parent.right
        anchors.rightMargin: dp(10)
        anchors.bottom: parent.bottom
        anchors.bottomMargin: dp(10)
        onClicked: {
            fileDialog.open()
        }
    }

    rightBarItem: IconButtonBarItem {
        icon: IconType.plus

        onClicked: {
            // Add a new item and notify listview model
            fileDialog.open()
        }
    }



    model: []

    delegate: SwipeOptionsContainer {
        id: container

        rightOption: AppButton {
            text: qsTr("upload")

            onClicked: {
                uploadfile.upFile(filepatch);
                container.hideOptions()

                // Remove selected item and notify listview model
                //masterPage.model.splice(index, 1)
                //masterPage.modelChanged()
            }
        }



        SimpleRow {
            onSelected: {
                masterPage.navigationStack.popAllExceptFirstAndPush(Qt.resolvedUrl("DetailPage.qml"), { content: item.text })
            }
        }
    }
}
