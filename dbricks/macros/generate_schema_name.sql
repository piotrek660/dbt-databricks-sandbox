{#- Sets the datasets name, based on the target environment and the models parent folders -#}
{% macro generate_schema_name(custom_schema_name=none, node=none) -%}


    {#- If they are elementary models, put into meta dataset -#}
    {%- if "dbt_artifacts" in node.fqn -%}
        dbt_artifacts
    {%- elif "dbt_project_evaluator" in node.fqn -%}
        dbt_project_evaluator
    {%- else -%}

        {#- Parent folders prefix or generic package name -#}
        {%- if node.fqn[2] is defined-%}
            {{- node.fqn[1] -}}
        {%- else -%}
            {{- node.package_name -}}
        {%- endif -%}

    {%- endif -%}

{%- endmacro %}
