
#!/usr/bin/env cwl-runner

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/

s:author:
  - class: s:Person
    s:email: andrew.lamb@sagebase.org
    s:name: Andrew Lamb

cwlVersion: v1.0
class: CommandLineTool
baseCommand: 
  - synapse
  - set-annotations

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/synapsepythonclient:v1.9.2

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
