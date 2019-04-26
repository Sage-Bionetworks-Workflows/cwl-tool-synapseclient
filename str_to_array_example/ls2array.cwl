class: Workflow
cwlVersion: v1.0
label: ls to array of strings

doc: |
    Run the Unix `ls` command on an input directory and return a list the list
    of files as an array of strings.

inputs:
  - id: folder
    type: Directory

outputs:
  - id: ls_lines
    type:
      type: array
      items: string
    outputSource: parse_stdout/stdout_lines

requirements:
  - class: StepInputExpressionRequirement

steps:
  - id: list_files
    run: ls.cwl
    in:
      folder: folder
    out: [stdout_text]

  - id: parse_stdout
    run: stdout2array.cwl
    in:
      stdout_text: list_files/stdout_text
    out: [stdout_lines]