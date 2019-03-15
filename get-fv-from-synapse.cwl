#!/usr/bin/env cwl-runner
class: CommandLineTool
id: get-fv-from-synapse
label: get-fv-from-synapse
cwlVersion: v1.0

requirements:
  - class: DockerRequirement
    dockerPull: sagebionetworks/synapsepythonclient
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
  - id: synapse_fv
    type: stdout

stdout: fileview.tsv

baseCommand: synapse
