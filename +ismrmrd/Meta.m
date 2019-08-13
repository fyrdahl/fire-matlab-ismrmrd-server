classdef Meta < handle

    properties
        DataRole
        ImageComment
        SeriesDescription
        ImageType
        RescaleIntercept
        RescaleSlope
        WindowCenter
        WindowWidth
        LUTFileName
        EchoTime
        InversionTime
        ROI
        DirectSend
    end

    methods

        function xmlstring = serialize(obj)

        docNode = javaObject('org.apache.xerces.dom.DocumentImpl');
        docNode.appendChild (docNode.createElement('ismrmrdMeta'));
        docRootNode = docNode.getDocumentElement;

            if ~isempty(obj.DataRole)
                metaNode = docNode.createElement('meta');

                nameNode = docNode.createElement('name');
                nameNode.appendChild(docNode.createTextNode('DataRole'));

                valueNode = docNode.createElement('value');
                valueNode.appendChild(docNode.createTextNode(obj.DataRole));

                metaNode.appendChild(nameNode);
                metaNode.appendChild(valueNode);

                docRootNode.appendChild(metaNode);
            end

            if ~isempty(obj.ImageComment)
                metaNode = docNode.createElement('meta');

                nameNode = docNode.createElement('name');
                nameNode.appendChild(docNode.createTextNode('ImageComment'));

                valueNode = docNode.createElement('value');
                valueNode.appendChild(docNode.createTextNode(obj.ImageComment));

                metaNode.appendChild(nameNode);
                metaNode.appendChild(valueNode);

                docRootNode.appendChild(metaNode);
            end

            if ~isempty(obj.SeriesDescription)
                metaNode = docNode.createElement('meta');

                nameNode = docNode.createElement('name');
                nameNode.appendChild(docNode.createTextNode('SeriesDescription'));

                valueNode = docNode.createElement('value');
                valueNode.appendChild(docNode.createTextNode(obj.SeriesDescription));

                metaNode.appendChild(nameNode);
                metaNode.appendChild(valueNode);

                docRootNode.appendChild(metaNode);
            end

            if ~isempty(obj.ImageType)
                metaNode = docNode.createElement('meta');

                nameNode = docNode.createElement('name');
                nameNode.appendChild(docNode.createTextNode('ImageType'));

                valueNode = docNode.createElement('value');
                valueNode.appendChild(docNode.createTextNode(obj.ImageType));

                metaNode.appendChild(nameNode);
                metaNode.appendChild(valueNode);

                docRootNode.appendChild(metaNode);
            end

            if ~isempty(obj.RescaleIntercept)
                metaNode = docNode.createElement('meta');

                nameNode = docNode.createElement('name');
                nameNode.appendChild(docNode.createTextNode('RescaleIntercept'));

                valueNode = docNode.createElement('value');
                valueNode.appendChild(docNode.createTextNode(double2str(obj.RescaleIntercept)));

                metaNode.appendChild(nameNode);
                metaNode.appendChild(valueNode);

                docRootNode.appendChild(metaNode);
            end
            if ~isempty(obj.RescaleSlope)
                metaNode = docNode.createElement('meta');

                nameNode = docNode.createElement('name');
                nameNode.appendChild(docNode.createTextNode('RescaleSlope'));

                valueNode = docNode.createElement('value');
                valueNode.appendChild(docNode.createTextNode(double2str(obj.RescaleSlope)));

                metaNode.appendChild(nameNode);
                metaNode.appendChild(valueNode);

                docRootNode.appendChild(metaNode);
            end
            if ~isempty(obj.WindowCenter)
                metaNode = docNode.createElement('meta');

                nameNode = docNode.createElement('name');
                nameNode.appendChild(docNode.createTextNode('WindowCenter'));

                valueNode = docNode.createElement('value');
                valueNode.appendChild(docNode.createTextNode(int2str(obj.WindowCenter)));

                metaNode.appendChild(nameNode);
                metaNode.appendChild(valueNode);

                docRootNode.appendChild(metaNode);
            end

            if ~isempty(obj.WindowWidth)
                metaNode = docNode.createElement('meta');

                nameNode = docNode.createElement('name');
                nameNode.appendChild(docNode.createTextNode('WindowWidth'));

                valueNode = docNode.createElement('value');
                valueNode.appendChild(docNode.createTextNode(int2str(obj.WindowWidth)));

                metaNode.appendChild(nameNode);
                metaNode.appendChild(valueNode);

                docRootNode.appendChild(metaNode);
            end

            if ~isempty(obj.LUTFileName)
                metaNode = docNode.createElement('meta');

                nameNode = docNode.createElement('name');
                nameNode.appendChild(docNode.createTextNode('LUTFileName'));

                valueNode = docNode.createElement('value');
                valueNode.appendChild(docNode.createTextNode(obj.LUTFileName));

                metaNode.appendChild(nameNode);
                metaNode.appendChild(valueNode);

                docRootNode.appendChild(metaNode);
            end

            if ~isempty(obj.EchoTime)
                metaNode = docNode.createElement('meta');

                nameNode = docNode.createElement('name');
                nameNode.appendChild(docNode.createTextNode('EchoTime'));

                valueNode = docNode.createElement('value');
                valueNode.appendChild(docNode.createTextNode(double2str(obj.EchoTime)));

                metaNode.appendChild(nameNode);
                metaNode.appendChild(valueNode);

                docRootNode.appendChild(metaNode);
            end

            if ~isempty(obj.InversionTime)
                metaNode = docNode.createElement('meta');

                nameNode = docNode.createElement('name');
                nameNode.appendChild(docNode.createTextNode('InversionTime'));

                valueNode = docNode.createElement('value');
                valueNode.appendChild(docNode.createTextNode(double2str(obj.InversionTime)));

                metaNode.appendChild(nameNode);
                metaNode.appendChild(valueNode);

                docRootNode.appendChild(metaNode);
            end

            if ~isempty(obj.ROI)
                metaNode = docNode.createElement('meta');

                nameNode = docNode.createElement('name');
                nameNode.appendChild(docNode.createTextNode('ROI'));

                valueNode = docNode.createElement('value');
                valueNode.appendChild(docNode.createTextNode(obj.ROI));

                metaNode.appendChild(nameNode);
                metaNode.appendChild(valueNode);

                docRootNode.appendChild(metaNode);
            end

            if ~isempty(obj.DirectSend)
                metaNode = docNode.createElement('meta');

                nameNode = docNode.createElement('name');
                nameNode.appendChild(docNode.createTextNode('DirectSend'));

                valueNode = docNode.createElement('value');
                if obj.DirectSend
                    valueNode.appendChild(docNode.createTextNode('true'));
                else
                    valueNode.appendChild(docNode.createTextNode('false'));
                end
                metaNode.appendChild(nameNode);
                metaNode.appendChild(valueNode);

                docRootNode.appendChild(metaNode);
            end

            xmlstring = char(xmlwrite(docNode));
            xmlstring(end+1) = char(0);
        end

    end
end
