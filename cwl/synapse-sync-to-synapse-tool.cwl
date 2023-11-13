#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

id: sync-to-synapse
label: Sync to Synapse tool

requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entryname: .synapseConfig
    entry: $(inputs.synapse_config)
  - $(inputs.files)

inputs:
- id: synapse_config
  type: File
- id: files
  type: File[]
- id: manifest_file
  type: File

outputs: []

baseCommand: synapse
arguments:
- valueFrom: sync
- valueFrom: $(inputs.manifest_file.path)

hints:
  DockerRequirement:
    dockerPull: 
      $include: ../synapseclient-version.txt

s:author:
- class: s:Person
  s:email: andrew.lamb@sagebase.org
  s:identifier: https://orcid.org/0000-0002-0326-7494
  s:name: Andrew Lamb

s:contributor:
- class: s:Person
  s:email: thomas.yu@sagebionetworks.org
  s:identifier: https://orcid.org/0000-0002-5841-0198
  s:name: Thomas Yu

s:codeRepository: https://github.com/Sage-Bionetworks-Workflows/cwl-tool-synapseclient/
s:license: https://spdx.org/licenses/Apache-2.0

$namespaces:
  s: https://schema.org/