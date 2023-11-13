#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

id: synapse-store
label: Synapse command line client subcommand for storing a file.

requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entryname: .synapseConfig
    entry: $(inputs.synapse_config)

inputs:
- id: synapse_config
  type: File
- id: file_to_store
  type: File
- id: parentid
  type: string
- id: name
  type: string?
- id: used
  type: string[]?
- id: executed
  type: string[]?

outputs:
- id: stdout
  type: File
  outputBinding:
    glob: stdout.txt
- id: file_id
  type: string
  outputBinding:
    glob: stdout.txt
    outputEval: $(self[0].contents.split("\n")[5].split(/(\s+)/)[4])
    loadContents: true
stdout: stdout.txt

baseCommand: synapse
arguments:
- valueFrom: store
- prefix: --parentId
  valueFrom: $(inputs.parentid)
- prefix: --used
  valueFrom: $(inputs.used)
- prefix: --executed
  valueFrom: $(inputs.executed)
- prefix: --name
  valueFrom: $(inputs.name)
- prefix: --
  valueFrom: $(inputs.file_to_store.path)

hints:
  DockerRequirement:
    dockerPull: 
      $include: ../synapseclient-version.txt

s:author:
- class: s:Person
  s:email: kenneth.daily@sagebionetworks.org
  s:identifier: https://orcid.org/0000-0001-5729-7376
  s:name: Kenneth Daily

s:contributor:
- class: s:Person
  s:email: andrew.lamb@sagebase.org
  s:identifier: https://orcid.org/0000-0002-0326-7494
  s:name: Andrew Lamb
- class: s:Person
  s:email: thomas.yu@sagebase.org
  s:identifier: https://orcid.org/0000-0002-5841-0198
  s:name: Thomas Yu
  
s:codeRepository: https://github.com/Sage-Bionetworks-Workflows/cwl-tool-synapseclient/
s:license: https://spdx.org/licenses/Apache-2.0

$namespaces:
  s: https://schema.org/