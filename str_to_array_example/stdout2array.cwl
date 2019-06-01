#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.0
label: standard out to array

doc: |
    Take standard output text (in a file) and split lines to return
    an array of strings.

baseCommand: echo
stdout: message

requirements:
- class: InlineJavascriptRequirement

inputs:
- id: stdout_text
  type: File
  inputBinding:
    loadContents: true

outputs:
- id: stdout_lines
  type:
    type: array
    items: string  
  outputBinding:
    glob: message
    loadContents: true
    outputEval: $(inputs.stdout_text.contents.split('\n'))




