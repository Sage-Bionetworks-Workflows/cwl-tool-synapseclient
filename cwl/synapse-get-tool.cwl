#!/usr/bin/env cwl-runner
#

cwlVersion: v1.0
id: "synapse-get"
label: "Synapse Get Tool"
class: CommandLineTool
baseCommand: synapse

$namespaces:
    dct: http://purl.org/dc/terms/
    foaf: http://xmlns.com/foaf/0.1/

dct:creator:
  "@id": "https://orcid.org/0000-0002-5841-0198"
  foaf:name: Thomas Yu
  foaf:mbox: "mailto:thomas.yu@sagebionetworks.org"

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/synapsepythonclient:v2.1.0

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
