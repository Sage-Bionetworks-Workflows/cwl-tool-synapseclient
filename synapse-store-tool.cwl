#!/usr/bin/env cwl-runner
#

class: CommandLineTool
id: "synapse-store"
label: "Synapse command line client subcommand for storing a file."

cwlVersion: v1.0

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/

dct:creator:
  "@id": "https://orcid.org/0000-0001-5729-7376"
  foaf:name: Kenneth Daily
  foaf:mbox: "mailto:kenneth.daily@sagebionetworks.org"

baseCommand: synapse

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/synapsepythonclient:v1.9.2

inputs:
  - id: synapse_config
    type: File
  - id: file_to_store
    type: File
  - id: parentid
    type: string

requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: .synapseConfig
        entry: $(inputs.synapse_config)

arguments:
  - valueFrom: store
  - valueFrom: $(inputs.parentid)
    prefix: --parentId
  - valueFrom: $(inputs.file_to_store.path)

stdout: stdout.txt

outputs:
  - id: stdout
    type: File
    outputBinding:
      glob: stdout.txt
