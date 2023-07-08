#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

id: synapse-set-annotations
label: Synapse set annotations tool

requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entryname: .synapseConfig
    entry: $(inputs.synapse_config)

inputs:
- id: synapse_config
  type: File
- id: synapseid
  type: string
  inputBinding:
    prefix: --id
- id: annotations_text
  type: string
  inputBinding:
    prefix: --annotations
- id: replace
  type: boolean
  default: true
  inputBinding:
    prefix: --replace

outputs: []

baseCommand:
- synapse
- set-annotations

hints:
  DockerRequirement:
    dockerPull: 
      $include: ../synapseclient-version.txt

s:author:
- class: s:Person
  s:email: andrew.lamb@sagebase.org
  s:identifier: https://orcid.org/0000-0002-0326-7494
  s:name: Andrew Lamb

s:codeRepository: https://github.com/Sage-Bionetworks-Workflows/cwl-tool-synapseclient/
s:license: https://spdx.org/licenses/Apache-2.0

$namespaces:
  s: https://schema.org/