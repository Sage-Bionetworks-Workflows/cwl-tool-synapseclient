
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
  - get-annotations

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

  - id: output_file_name
    type: string
    default: "annotations.json"

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .synapseConfig
        entry: $(inputs.synapse_config)


stdout: $(inputs.output_file_name)
     
outputs:

  - id: annotations_file
    type: File
    outputBinding:
      glob: $(inputs.output_file_name)

  - id: annotations_text
    type: string
    outputBinding:
      glob: $(inputs.output_file_name)
      loadContents: true
      outputEval: $(self[0].contents)
