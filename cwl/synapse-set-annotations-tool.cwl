
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
baseCommand: 
  - synapse
  - set-annotations

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/synapsepythonclient:v2.1.0

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

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .synapseConfig
        entry: $(inputs.synapse_config)

outputs: []
