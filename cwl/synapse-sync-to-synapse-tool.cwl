#!/usr/bin/env cwl-runner

cwlVersion: v1.0
id: "sync-to-synapse"
label: "Sync to Synapse tool"
class: CommandLineTool
baseCommand: synapse

$namespaces:
  s: https://schema.org/

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-0326-7494
    s:email: andrew.lamb@sagebase.org
    s:name: Andrew Lamb

s:contributor:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-5841-0198
    s:email: thomas.yu@sagebionetworks.org
    s:name: Thomas Yu

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/synapsepythonclient:v2.5.1
    
inputs:
  - id: synapse_config
    type: File
  - id: files
    type: File[]
  - id: manifest_file
    type: File

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .synapseConfig
        entry: $(inputs.synapse_config)
      - $(inputs.files)

arguments:
  - valueFrom: sync
  - valueFrom: $(inputs.manifest_file.path)

outputs: []
