#!/usr/bin/env cwl-runner
#

cwlVersion: v1.0
id: "synapse-get-sts"
label: "Synapse Get STS Token Tool"
class: CommandLineTool
baseCommand: synapse
stdout: output.json

$namespaces:
  s: https://schema.org/

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-5841-0198
    s:email: thomas.yu@sagebionetworks.org
    s:name: Thomas Yu

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/synapsepythonclient:v2.5.1

inputs:
  - id: synapse_config
    type: File
  - id: synapseid
    type: string
  - id: permission
    type: string

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: .synapseConfig
        entry: $(inputs.synapse_config)

arguments:
  - valueFrom: get-sts-token
  - valueFrom: $(inputs.synapseid)
  - valueFrom: $(inputs.permission)
  - valueFrom: json
    prefix: --output


outputs:
  - id: json_out
    type: stdout

  - id: bucket
    type: string
    outputBinding:
      glob: output.json
      loadContents: true
      outputEval: $(JSON.parse(self[0].contents)['bucket'])

  - id: basekey
    type: string
    outputBinding:
      glob: output.json
      loadContents: true
      outputEval: $(JSON.parse(self[0].contents)['baseKey'])

  - id: accesskey_id
    type: string
    outputBinding:
      glob: output.json
      loadContents: true
      outputEval: $(JSON.parse(self[0].contents)['accessKeyId'])
    
  - id: secret_accesskey
    type: string
    outputBinding:
      glob: output.json
      loadContents: true
      outputEval: $(JSON.parse(self[0].contents)['secretAccessKey'])

  - id: session_token
    type: string
    outputBinding:
      glob: output.json
      loadContents: true
      outputEval: $(JSON.parse(self[0].contents)['sessionToken'])
