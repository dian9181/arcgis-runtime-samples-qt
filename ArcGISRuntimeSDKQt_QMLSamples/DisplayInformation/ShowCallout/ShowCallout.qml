// [WriteFile Name=ShowCallout, Category=DisplayInformation]
// [Legal]
// Copyright 2016 Esri.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// [Legal]

import QtQuick 2.6
import Esri.ArcGISExtras 1.1
import Esri.ArcGISRuntime 100.0
import Esri.ArcGISRuntime.Toolkit.Controls 2.0

Rectangle {
    clip: true

    width: 800
    height: 600

    property real scaleFactor: System.displayScaleFactor
    property Point calloutLocation
    property real xCoor
    property real yCoor

    // Map view UI presentation at top
    MapView {
        id: mapView
        anchors.fill: parent

        Map {
            BasemapTopographic {}

            // initial Viewpoint
            ViewpointCenter {
                Point {
                    x: -1.2e7
                    y: 5e6
                    spatialReference: SpatialReference.createWebMercator()
                }
                scale: 1e7
            }
        }

        //! [show callout qml api snippet]
        // initialize Callout
        calloutData {
            imageUrl: "qrc:/Samples/DisplayInformation/ShowCallout/RedShinyPin.png"
            title: "Location"
            location: calloutLocation
            detail: "x: " + xCoor + " y: " + yCoor;
        }

        Callout {
            id: callout
            calloutData: parent.calloutData
        }
        //! [show callout qml api snippet]

        // display callout on mouseclick
        onMouseClicked: {
            if (callout.calloutVisible)
                callout.dismiss()
            else
            {
                calloutLocation = mouse.mapPoint;
                xCoor = mouse.mapPoint.x.toFixed(2);
                yCoor = mouse.mapPoint.y.toFixed(2);
                callout.showCallout();
            }
        }
    }

    // Neatline rectangle
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border {
            width: 0.5 * scaleFactor
            color: "black"
        }
    }
}
