#!/usr/bin/env cwl-runner

$namespaces:
  s: https://schema.org/

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-0326-7494
    s:email: andrew.lamb@sagebase.org
    s:name: Andrew Lamb

cwlVersion: v1.0
class: CommandLineTool

requirements:
- class: InitialWorkDirRequirement
  listing: $(inputs.files)

hints:
  DockerRequirement:
    dockerPull: quay.io/andrewelamb/python_synapse_client
    
baseCommand:
- python3
- /usr/local/bin/sync_to_synapse.py

inputs:

  files: File[]
      
  synapse_config:
    type: File
    inputBinding:
      prefix: "--synapse_config_file"

  manifest_file:
    type: File
    inputBinding:
      prefix: "--manifest_file"

 
outputs: []
