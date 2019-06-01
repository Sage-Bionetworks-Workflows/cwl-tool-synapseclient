
#!/usr/bin/env cwl-runner
#
# Authors: Andrew Lamb

cwlVersion: v1.0
class: CommandLineTool
baseCommand: 
  - synapse
  - get-annotations

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

  - id: output_file_name
    type: string
    default: "annotations.json"
    inputBinding:
      prefix: --output

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .synapseConfig
        entry: $(inputs.synapse_config)


     
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
