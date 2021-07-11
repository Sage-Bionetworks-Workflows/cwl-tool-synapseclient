#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: "synapse-create"
label: "Synapse command line client subcommand for creating a project/folder."

baseCommand: 
  - synapse
  - create

$namespaces:
  s: https://schema.org/

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-4621-1589
    s:email: bruno.grande@sagebase.org
    s:name: Bruno Grande

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/synapsepythonclient:v2.4.0

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
      symbols: [Project, Folder]
    inputBinding:
      position: 2

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .synapseConfig
        entry: $(inputs.synapse_config)

stdout: stdout.txt

outputs:
  - id: stdout
    type: File
    outputBinding:
      glob: stdout.txt
  - id: file_id
    type: string
    outputBinding:
      glob: stdout.txt
      loadContents: true
      outputEval: $(self[0].contents.split("\n")[0].split(/(\s+)/)[4])

# Example command and output of synapse create:
#
#   $ synapse create -parentId syn23344520 -name testDir Folder
#   Created entity: syn23416766	testDir
#
# Steps to access the Synapse ID
#
#   1. Access line 1: "contents.split("\n")[0]"
#   2. Split by whitespace: ".split(/(\s+)/)"
#   3. Access the the 5th item: "[4]"
