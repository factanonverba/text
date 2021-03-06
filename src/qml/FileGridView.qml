/*
 * Copyright © 2016-2017 Andrew Penkrat
 *
 * This file is part of Liri Text.
 *
 * Liri Text is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Liri Text is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Liri Text.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.8
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0
import Fluid.Controls 1.0 as FluidControls
import Fluid.Material 1.0 as FluidMaterial

Flickable {
    id: rootFlickable

    property alias model: fileGridContents.model
    property int cardWidth: 240
    property int viewLines: 7
    property int lineHeight: 20
    property int descriptionRectangleHeight: 16 + 16 + 14 + 12 + 16
    property int cardHeight: viewLines * lineHeight + 2*8 + descriptionRectangleHeight

    anchors.fill: parent
    contentHeight: fileGrid.height

    ScrollBar.vertical: ScrollBar { }

    Grid {
        id: fileGrid

        padding: 24
        spacing: 4
        columns: ~~((parent.width - 2*padding + spacing) / (cardWidth + spacing))
        width: columns * (cardWidth + spacing) - spacing + 2*padding
        anchors.horizontalCenter: parent.horizontalCenter

        Repeater {
            id: fileGridContents

            delegate: FluidControls.Card {
                id: fileCard

                contentWidth: cardWidth
                contentHeight: cardHeight

                Rectangle {
                    color: "white"
                    clip: true
                    anchors.fill: parent

                    Text {
                        id: filePreview

                        anchors {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                            bottom: nameBackground.top
                            margins: 8
                            rightMargin: 4
                        }
                        clip: true

                        font.pixelSize: FluidControls.FluidStyle.body1Font.pixelSize
                        maximumLineCount: rootFlickable.viewLines
                        lineHeightMode: Text.FixedHeight
                        lineHeight: rootFlickable.lineHeight

                        textFormat: Text.RichText
                        text: previewText
                    }

                    LinearGradient {
                        anchors.fill: parent
                        cached: true
                        start: Qt.point(parent.width - 28, 0)
                        end: Qt.point(filePreview.width + filePreview.x, 0)
                        gradient: Gradient {
                            GradientStop {position: 0.0; color: "transparent"}
                            GradientStop {position: 1.0; color: "white"}
                        }
                    }

                    Rectangle {
                        id: nameBackground
                        color: "black"
                        opacity: 0.5
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: rootFlickable.descriptionRectangleHeight
                    }

                    Label {
                        id: docName

                        anchors.top: nameBackground.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.topMargin: 16
                        anchors.leftMargin: 16
                        anchors.rightMargin: 16

                        text: name
                        color: "white"
                        font.pixelSize: 16
                        font.weight: Font.Medium
                        elide: Text.ElideRight
                    }

                    Label {
                        id: docUrl

                        anchors.bottom: nameBackground.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottomMargin: 16
                        anchors.leftMargin: 16
                        anchors.rightMargin: 16

                        text: filePath
                        color: "white"
                        font.pixelSize: 12
                        font.weight: Font.Normal
                        elide: Text.ElideMiddle
                    }
                }

                FluidMaterial.Ripple {
                    id: animation
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton

                    onClicked: {
                        if(mouse.button === Qt.LeftButton) {
                            pageStack.push(Qt.resolvedUrl("EditPage.qml"), {documentUrl: fileUrl})
                        }
                    }
                }
            }
        }
    }
}
