#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

id: synapse-query-tool
label: synapse-query-tool

requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: .synapseConfig
    entry: $(inputs.synapse_config)

inputs:
  query:
    doc: query
    type: string
    inputBinding:
      prefix: query
      position: 1
  synapse_config:
    doc: synapseConfig file
    type: File

outputs:
- id: query_result
  type: stdout
stdout: query_result.tsv

baseCommand: synapse

hints:
  DockerRequirement:
    dockerPull: 
      $include: ../synapseclient-version.txt

s:author:
- class: s:Person
  s:email: thomas.yu@sagebionetworks.org
  s:identifier: https://orcid.org/0000-0002-5841-0198
  s:name: Thomas Yu

s:codeRepository: https://github.com/Sage-Bionetworks-Workflows/cwl-tool-synapseclient/
s:license: https://spdx.org/licenses/Apache-2.0

$namespaces:
  s: https://schema.org/
