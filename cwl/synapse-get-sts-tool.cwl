#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

id: synapse-get-sts
label: Synapse Get STS Token Tool

requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entryname: .synapseConfig
    entry: $(inputs.synapse_config)

inputs:
- id: synapse_config
  type: File
- id: synapseid
  type: string
- id: permission
  type: string

outputs:
- id: json_out
  type: stdout
- id: bucket
  type: string
  outputBinding:
    glob: output.json
    outputEval: $(JSON.parse(self[0].contents)['bucket'])
    loadContents: true
- id: basekey
  type: string
  outputBinding:
    glob: output.json
    outputEval: $(JSON.parse(self[0].contents)['baseKey'])
    loadContents: true
- id: accesskey_id
  type: string
  outputBinding:
    glob: output.json
    outputEval: $(JSON.parse(self[0].contents)['accessKeyId'])
    loadContents: true
- id: secret_accesskey
  type: string
  outputBinding:
    glob: output.json
    outputEval: $(JSON.parse(self[0].contents)['secretAccessKey'])
    loadContents: true
- id: session_token
  type: string
  outputBinding:
    glob: output.json
    outputEval: $(JSON.parse(self[0].contents)['sessionToken'])
    loadContents: true
stdout: output.json

baseCommand: synapse
arguments:
- valueFrom: get-sts-token
- valueFrom: $(inputs.synapseid)
- valueFrom: $(inputs.permission)
- prefix: --output
  valueFrom: json

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