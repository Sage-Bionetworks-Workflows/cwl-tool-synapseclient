#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.0
label: ls to array

doc: |
  Run Unix `ls` command on an input directory and save standard out to
  a file.

baseCommand:
  - ls
stdout: message

requirements:
  - class: InlineJavascriptRequirement

inputs:
  - id: folder
    type: Directory
    inputBinding:
      position: 1

outputs:
  - id: stdout_text
    type: stdout
