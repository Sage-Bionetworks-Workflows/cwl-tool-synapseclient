#!/usr/bin/cwl-runner
class: CommandLineTool
label: join-fileview-by-specimen-tool
id: join-fileview-by-specimen-tool
cwlVersion: v1.0

baseCommand:
  - python
  - /usr/local/bin/join-fileview-by-specimen.py

requirements:
- class: DockerRequirement
  dockerPull: sgosline/manifest-merge

inputs:
  filelist:
    type: File[]
    inputBinding:
      prefix: --filelist
  values:
    type: string[]
    inputBinding:
      prefix: --values
  manifest_file:
    type: File
    inputBinding:
      prefix: --manifest_file
  parentid:
    type: string
    inputBinding:
      prefix: --parentId
  key:
    type: string
    inputBinding:
      prefix: --key
  # used:
  #   type: string[]
  #   inputBinding:
  #     prefix: --used
  # executed:
  #   type: string[]
  #   inputBinding:
  #     prefix: --executed

outputs:
  newmanifest:
    type: stdout


stdout: query_result.tsv
