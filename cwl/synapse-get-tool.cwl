#!/usr/bin/env cwl-runner

cwlVersion: v1.0
id: "synapse-get"
label: "Synapse Get Tool"
class: CommandLineTool
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

inputs:
  - id: synapse_config
    type: File
  - id: synapseid
    type: string

requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: .synapseConfig
        entry: $(inputs.synapse_config)

arguments:
  - valueFrom: get
  - valueFrom: $(inputs.synapseid)
     
outputs:
  - id: filepath
    type: File
    outputBinding:
      glob: '*'
