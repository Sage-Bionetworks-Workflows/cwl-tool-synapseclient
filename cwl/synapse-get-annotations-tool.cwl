#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

id: synapse-get-annotations
label: Synapse get annotations tool

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
- id: output_file_name
  type: string
  default: annotations.json

outputs:
- id: annotations_file
  type: File
  outputBinding:
    glob: $(inputs.output_file_name)
- id: annotations_text
  type: string
  outputBinding:
    glob: $(inputs.output_file_name)
    outputEval: $(self[0].contents)
    loadContents: true
stdout: $(inputs.output_file_name)

baseCommand:
- synapse
- get-annotations

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