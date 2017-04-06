// [WriteFile Name=RasterLayerFile, Category=Layers]
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
import QtQuick.Dialogs 1.2

Item {
    id: root
    signal rasterFileChosen(string url);

    property var supportedExtensions: []
    property alias folder: fileDialog.folder

    function open() {
        fileDialog.open();
    }

    DropArea {
        anchors.fill: parent

        onDropped: {
            if (!drop.hasText)
                return;

            if (drop.urls.length !== 1)
                return;

            if (!root.validateFileExtension(drop.urls[0]))
                return;

            if (drop.proposedAction !== Qt.MoveAction && drop.proposedAction !== Qt.CopyAction)
                return;

            drop.acceptProposedAction();
            root.rasterFileChosen(drop.urls[0]);
        }
    }

    FileDialog {
        id: fileDialog

        onAccepted: {
            root.rasterFileChosen(fileDialog.fileUrl)
        }
    }

    function validateFileExtension(filePath) {
        var extension = filePath.split('.').pop();
        var idx = supportedExtensions.indexOf(extension);

        return idx !== -1;
    }

    onSupportedExtensionsChanged: {
        var nameFiltersString = "Raster files (";
        for (var i = 0; i < supportedFormats.length; i++)
            nameFiltersString += "*." + supportedFormats[i] + " ";

        nameFiltersString += ")";
        fileDialog.nameFilters = nameFiltersString;
    }
}
