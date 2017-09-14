[#case "redirector"]
    [#switch containerListMode]
        [#case "definition"]
            [@containerBasicAttributes
                containerName
                "docker-redirector" + dockerTag
            /]
            [#break]

        [#case "environmentCount"]
        [#case "environment"]
        [#case "volumeCount"]
        [#case "volumes"]
        [#case "mountPointCount"]
        [#case "mountPoints"]
            [@containerVolume
                "redirector"
                "/var/lib/redirector"
                "/codeontap/redirector" /]
            [#break]
    [/#switch]
    [#break]
