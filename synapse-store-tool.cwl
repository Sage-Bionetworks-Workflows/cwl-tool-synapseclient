#!/usr/bin/env cwl-runner
#

class: CommandLineTool
id: "synapse-store"
label: "Synapse command line client subcommand for storing a file."

cwlVersion: v1.0

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/

dct:creator:
  "@id": "https://orcid.org/0000-0001-5729-7376"
  foaf:name: Kenneth Daily
  foaf:mbox: "mailto:kenneth.daily@sagebionetworks.org"

baseCommand: synapse

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/synapsepythonclient:v1.9.2

inputs:
  - id: synapse_config
    type: File
  - id: file_to_store
    type: File
  - id: parentid
    type: string

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .synapseConfig
        entry: $(inputs.synapse_config)

arguments:
  - valueFrom: store
  - valueFrom: $(inputs.parentid)
    prefix: --parentId
  - valueFrom: $(inputs.file_to_store.path)

stdout: stdout.txt

outputs:
  - id: stdout
    type: File
    outputBinding:
      glob: stdout.txt

# stdout from synstore is in this format:
#
###################################################
# Uploading file to Synapse storage 
###################################################
#
#Created/Updated entity: syn18493874     559d86e397be9ba39950b631dd9652148282a575
#
#1. Access line 6: "contents.split("\n")[5]"
#2. Split by whitespace: ".split(/(\s+)/)"
#3. Access the the 5th item: "[4]"


  - id: file_id
    type: string
    outputBinding:
      glob: stdout.txt
      loadContents: true
      outputEval: $(self[0].contents.split("\n")[5].split(/(\s+)/)[4])
