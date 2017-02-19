[#ftl]
[#assign resourceCount = 0]
[#list tiers as tier]
    [#if tier.Components??]
        [#list tier.Components?values as component]
            [#if component?is_hash && component.Slices?seq_contains(slice)]
                [#if component.MultiAZ??]
                    [#assign multiAZ =  component.MultiAZ]
                [#else]
                    [#assign multiAZ =  solnMultiAZ]
                [/#if]
            [#include compositeList]
            [/#if]
        [/#list]
    [/#if]
[/#list]
