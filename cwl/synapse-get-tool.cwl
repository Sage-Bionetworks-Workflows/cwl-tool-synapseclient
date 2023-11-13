#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

id: synapse-get
label: Synapse Get Tool

requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: .synapseConfig
    entry: $(inputs.synapse_config)

inputs:
- id: synapse_config
  type: File
- id: synapseid
  type: string

outputs:
- id: filepath
  type: File
  outputBinding:
    glob: '*'

baseCommand: synapse
arguments:
- valueFrom: get
- valueFrom: $(inputs.synapseid)

hints:
  DockerRequirement:
    dockerPull: 
      $include: ../synapseclient-version.txt

s:author:
- class: s:Person
  s:email: thomas.yu@sagebionetworks.org
  s:identifier: https://orcid.org/0000-0002-5841-0198
  s:name: Thomas Yu

s:codeRepository: https://github.com/Sage-Bionetworks-Workflows/cwl-tool-synapseclient/
s:license: https://spdx.org/licenses/Apache-2.0

$namespaces:
  s: https://schema.org/