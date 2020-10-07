[#-- ECS Account Settings --]
[#if getDeploymentUnit()?contains("ecs") || (allDeploymentUnits!false) ]
    [#if deploymentSubsetRequired("generationcontract", false)]
        [@addDefaultGenerationContract subsets="epilogue" /]
    [/#if]

    [@includeServicesConfiguration
        provider=AWS_PROVIDER
        services=[ ]
        deploymentFramework=commandLineOptions.Deployment.Framework.Name
    /]

    [#assign ecsAccountSettings = {
                "serviceLongArnFormat" : true,
                "taskLongArnFormat" : true,
                "containerInstanceLongArnFormat" : true,
                "awsvpcTrunking" : true
    }]

    [#-- Allow of overriding the settings if required --]
    [#assign ecsAccountSettings = mergeObjects( ecsAccountSettings, (accountObject["aws:ecsAccountSettings"])!{} )]

    [#assign ecsAccountCommands = [] ]
    [#list ecsAccountSettings as setting,state ]
        [#assign ecsAccountCommands += [ r'manage_ecs_account_settings "' + region + r'" "' + setting + r'" "' + state?then("enabled", "disabled") + r'"' ]]
    [/#list]

    [#if deploymentSubsetRequired("epilogue", true)]
        [@addToDefaultBashScriptOutput
            content=
                [
                    r'case ${STACK_OPERATION} in',
                    r'  create|update)',
                    r'      info "Updating ECS Account Settings"'
                ] +
                ecsAccountCommands +
                [
                    r'      ;;',
                    r'esac'
                ]
        /]
    [/#if]
[/#if]