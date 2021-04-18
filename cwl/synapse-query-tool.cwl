#!/usr/bin/env cwl-runner
class: CommandLineTool
id: synapse-query-tool
label: synapse-query-tool
cwlVersion: v1.0
baseCommand: synapse

$namespaces:
  s: https://schema.org/

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-5841-0198
    s:email: thomas.yu@sagebionetworks.org
    s:name: Thomas Yu

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/synapsepythonclient:v2.3.1

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .synapseConfig
        entry: $(inputs.synapse_config)

inputs:
  synapse_config:
    type: File
    doc: synapseConfig file
  query:
    type: string
    inputBinding:
      position: 1
      prefix: query
    doc: query

outputs:
  - id: query_result
    type: stdout

stdout: query_result.tsv
