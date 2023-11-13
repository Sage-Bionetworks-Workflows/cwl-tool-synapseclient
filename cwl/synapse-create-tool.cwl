#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

id: synapse-create
label: Synapse command line client subcommand for creating a project/folder.

requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entryname: .synapseConfig
    entry: $(inputs.synapse_config)

inputs:
- id: synapse_config
  type: File
- id: parentid
  type: string?
  inputBinding:
    prefix: --parentId
- id: name
  type: string
  inputBinding:
    prefix: --name
- id: description
  type: string?
  inputBinding:
    prefix: --description
- id: description_file
  type: File?
  inputBinding:
    prefix: --descriptionFile
- id: type
  type:
    type: enum
    symbols:
    - Project
    - Folder
  inputBinding:
    position: 2

outputs:
- id: stdout
  type: File
  outputBinding:
    glob: stdout.txt
- id: file_id
  type: string
  outputBinding:
    glob: stdout.txt
    outputEval: $(self[0].contents.split("\n")[0].split(/(\s+)/)[4])
    loadContents: true
stdout: stdout.txt

baseCommand:
- synapse
- create

hints:
  DockerRequirement:
    dockerPull: 
      $include: ../synapseclient-version.txt

s:author:
- class: s:Person
  s:email: bruno.grande@sagebase.org
  s:identifier: https://orcid.org/0000-0002-4621-1589
  s:name: Bruno Grande

s:codeRepository: https://github.com/Sage-Bionetworks-Workflows/cwl-tool-synapseclient/
s:license: https://spdx.org/licenses/Apache-2.0

$namespaces:
  s: https://schema.org/